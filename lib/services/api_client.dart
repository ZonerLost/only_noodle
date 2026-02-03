import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../utils/error_handler.dart';
import 'storage/auth_storage.dart';

class ApiClient {
  ApiClient(this._storage, {http.Client? client})
      : _client = client ?? http.Client();

  final AuthStorage _storage;
  final http.Client _client;

  Future<dynamic> get(
    String path, {
    Map<String, String>? query,
    bool auth = true,
  }) {
    return _request('GET', path, query: query, auth: auth);
  }

  Future<dynamic> post(
    String path, {
    Map<String, String>? query,
    Object? body,
    bool auth = true,
  }) {
    return _request('POST', path, query: query, body: body, auth: auth);
  }

  Future<dynamic> patch(
    String path, {
    Map<String, String>? query,
    Object? body,
    bool auth = true,
  }) {
    return _request('PATCH', path, query: query, body: body, auth: auth);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, String>? query,
    Object? body,
    bool auth = true,
  }) {
    return _request('DELETE', path, query: query, body: body, auth: auth);
  }

  Future<dynamic> _request(
    String method,
    String path, {
    Map<String, String>? query,
    Object? body,
    bool auth = true,
    bool retrying = false,
  }) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}$path').replace(queryParameters: query);
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (auth) {
      final token = _storage.accessToken;
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    http.Response response;
    try {
      switch (method) {
        case 'GET':
          response = await _client.get(uri, headers: headers);
          break;
        case 'POST':
          response = await _client.post(
            uri,
            headers: headers,
            body: body == null ? null : jsonEncode(body),
          );
          break;
        case 'PATCH':
          response = await _client.patch(
            uri,
            headers: headers,
            body: body == null ? null : jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await _client.delete(
            uri,
            headers: headers,
            body: body == null ? null : jsonEncode(body),
          );
          break;
        default:
          throw ApiException(statusCode: 500, message: 'Unsupported method');
      }
    } catch (error) {
      throw ApiException(statusCode: 0, message: 'Network error', details: error);
    }

    if (response.statusCode == 401 && auth && !retrying) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        return _request(
          method,
          path,
          query: query,
          body: body,
          auth: auth,
          retrying: true,
        );
      }
    }

    final dynamic decoded = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decoded is Map<String, dynamic> && decoded.containsKey('data')) {
        return decoded['data'];
      }
      return decoded;
    }

    final message = parseApiErrorMessage(decoded, response.statusCode);
    throw ApiException(statusCode: response.statusCode, message: message, details: decoded);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = _storage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final role = _storage.role;
    final refreshPath = role == 'driver'
        ? '/driver/auth/refresh'
        : '/auth/refresh';

    try {
      final uri = Uri.parse('${AppConfig.apiBaseUrl}$refreshPath');
      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'refreshToken': refreshToken}),
      );
      final decoded = response.body.isEmpty ? null : jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (decoded is Map<String, dynamic>) {
          final data = decoded['data'] as Map<String, dynamic>?;
          final tokens = data?['tokens'] as Map<String, dynamic>?;
          final accessToken = tokens?['accessToken']?.toString() ??
              data?['accessToken']?.toString();
          final newRefresh = tokens?['refreshToken']?.toString() ??
              data?['refreshToken']?.toString();
          if (accessToken != null && newRefresh != null) {
            await _storage.saveTokens(
              accessToken: accessToken,
              refreshToken: newRefresh,
            );
            return true;
          }
        }
      }
    } catch (_) {
      // ignore refresh errors and fall through
    }
    await _storage.clear();
    return false;
  }
}
