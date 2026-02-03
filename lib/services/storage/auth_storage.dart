import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _roleKey = 'role';
  static const _userKey = 'user';
  static const _rememberMeKey = 'rememberMe';

  final SharedPreferences _prefs;

  AuthStorage(this._prefs);

  static Future<AuthStorage> init() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthStorage(prefs);
  }

  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);
  String? get role => _prefs.getString(_roleKey);
  bool get rememberMe => _prefs.getBool(_rememberMeKey) ?? false;

  Map<String, dynamic>? get user {
    final raw = _prefs.getString(_userKey);
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> saveRole(String role) async {
    await _prefs.setString(_roleKey, role);
  }

  Future<void> saveUser(Map<String, dynamic> userJson) async {
    await _prefs.setString(_userKey, jsonEncode(userJson));
  }

  Future<void> saveRememberMe(bool value) async {
    await _prefs.setBool(_rememberMeKey, value);
  }

  Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_roleKey);
    await _prefs.remove(_userKey);
    await _prefs.remove(_rememberMeKey);
  }
}
