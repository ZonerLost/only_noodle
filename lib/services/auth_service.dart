import '../models/user_profile.dart';
import '../utils/error_handler.dart';
import 'api_client.dart';
import 'endpoints/auth_endpoints.dart';
import 'storage/auth_storage.dart';

class AuthService {
  AuthService(this._client, this._storage);

  final ApiClient _client;
  final AuthStorage _storage;

  Future<UserProfile> register({
    required String email,
    required String password,
    required String phoneNumber,
    required bool agreeToPrivacyPolicy,
    bool rememberMe = false,
  }) async {
    final data = await _client.post(
      AuthEndpoints.register,
      auth: false,
      body: {
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'agreeToPrivacyPolicy': agreeToPrivacyPolicy,
      },
    );
    if (data is Map<String, dynamic>) {
      final userJson = data['user'] as Map<String, dynamic>?;
      final tokens = data['tokens'] as Map<String, dynamic>?;
      if (userJson != null && tokens != null) {
        return _handleAuthResponse(
          data,
          role: 'customer',
          rememberMe: rememberMe,
        );
      }
      if (userJson != null) {
        await _storage.saveRememberMe(rememberMe);
        return UserProfile.fromJson(userJson);
      }
      final emailValue = data['email']?.toString() ?? email;
      final phoneValue = data['phone']?.toString() ?? phoneNumber;
      await _storage.saveRememberMe(rememberMe);
      return UserProfile(
        id: '',
        email: emailValue,
        name: '',
        phone: phoneValue,
        language: '',
        profilePicture: '',
      );
    }
    await _storage.saveRememberMe(rememberMe);
    return UserProfile(
      id: '',
      email: email,
      name: '',
      phone: phoneNumber,
      language: '',
      profilePicture: '',
    );
  }

  Future<UserProfile> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final data = await _client.post(
        AuthEndpoints.login,
        auth: false,
        body: {
          'email': email,
          'password': password,
          'rememberMe': rememberMe,
        },
      );
      return _handleAuthResponse(
        data,
        role: 'customer',
        rememberMe: rememberMe,
      );
    } on ApiException catch (error) {
      if (error.statusCode == 401 || error.statusCode == 404) {
        final data = await _client.post(
          AuthEndpoints.driverLogin,
          auth: false,
          body: {
            'email': email,
            'password': password,
            'rememberMe': rememberMe,
          },
        );
        return _handleAuthResponse(
          data,
          role: 'driver',
          rememberMe: rememberMe,
        );
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final role = _storage.role;
    final path = role == 'driver' ? AuthEndpoints.driverLogout : AuthEndpoints.logout;
    try {
      await _client.post(path, body: {});
    } catch (_) {
      // ignore logout errors
    }
    await _storage.clear();
  }

  Future<void> verifyOtp({required String email, required String code}) async {
    await _client.post(
      AuthEndpoints.verifyOtp,
      auth: false,
      body: {'email': email, 'code': code},
    );
  }

  Future<void> resendOtp({required String email}) async {
    await _client.post(
      AuthEndpoints.resendOtp,
      auth: false,
      body: {'email': email},
    );
  }

  Future<UserProfile> completeProfile({required String fullName}) async {
    final data = await _client.post(
      AuthEndpoints.completeProfile,
      body: {'fullName': fullName},
    );
    if (data is Map<String, dynamic>) {
      final user = UserProfile.fromJson(data);
      await _storage.saveUser(user.toJson());
      return user;
    }
    throw ApiException(statusCode: 500, message: 'Invalid profile response');
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await _client.post(
        AuthEndpoints.forgotPassword,
        auth: false,
        body: {'email': email},
      );
    } on ApiException catch (error) {
      if (error.statusCode == 401 || error.statusCode == 404) {
        await _client.post(
          AuthEndpoints.driverForgotPassword,
          auth: false,
          body: {'email': email},
        );
        return;
      }
      rethrow;
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await _client.post(
      AuthEndpoints.resetPassword,
      auth: false,
      body: {'token': token, 'newPassword': newPassword},
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _client.post(
      AuthEndpoints.changePassword,
      body: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }

  UserProfile _handleAuthResponse(
    dynamic data, {
    required String role,
    required bool rememberMe,
  }) {
    if (data is Map<String, dynamic>) {
      final userJson = data['user'] as Map<String, dynamic>? ?? data['user'];
      final tokens = data['tokens'] as Map<String, dynamic>? ?? data['tokens'];
      final accessToken =
          tokens?['accessToken']?.toString() ?? data['accessToken']?.toString();
      final refreshToken =
          tokens?['refreshToken']?.toString() ?? data['refreshToken']?.toString();
      if (userJson != null && accessToken != null && refreshToken != null) {
        _storage.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
        _storage.saveRememberMe(rememberMe);
        _storage.saveRole(role);
        final user = UserProfile.fromJson(userJson);
        _storage.saveUser(user.toJson());
        return user;
      }
    }
    throw ApiException(statusCode: 500, message: 'Invalid auth response');
  }
}
