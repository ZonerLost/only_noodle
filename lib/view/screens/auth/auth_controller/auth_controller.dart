import 'package:get/get.dart';
import 'package:only_noodle/models/driver_profile.dart';
import 'package:only_noodle/models/user_profile.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

enum UserRole { driver, customer }

class AuthController extends GetxController {
  final selectedRole = UserRole.driver.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final user = Rxn<UserProfile>();
  final driver = Rxn<DriverProfile>();
  final role = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  bool get isDriver => role.value == 'driver';

  Future<void> _loadFromStorage() async {
    if (!ServiceLocator.authStorage.rememberMe) {
      await ServiceLocator.authStorage.clear();
      return;
    }
    final storedRole = ServiceLocator.authStorage.role;
    if (storedRole != null) {
      role.value = storedRole;
    }
    final storedUser = ServiceLocator.authStorage.user;
    if (storedUser != null) {
      user.value = UserProfile.fromJson(storedUser);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      final result = await ServiceLocator.authService.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      user.value = result;
      role.value = ServiceLocator.authStorage.role ?? 'customer';
      if (role.value == 'driver') {
        driver.value = await ServiceLocator.driverService.getProfile();
      }
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String phoneNumber,
    required bool agreeToPrivacyPolicy,
    bool rememberMe = false,
  }) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      final result = await ServiceLocator.authService.register(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        agreeToPrivacyPolicy: agreeToPrivacyPolicy,
        rememberMe: rememberMe,
      );
      user.value = result;
      role.value = ServiceLocator.authStorage.role ?? 'customer';
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyOtp({
    required String email,
    required String code,
  }) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await ServiceLocator.authService.verifyOtp(email: email, code: code);
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp({required String email}) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await ServiceLocator.authService.resendOtp(email: email);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> completeProfile({required String fullName}) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      final result = await ServiceLocator.authService.completeProfile(
        fullName: fullName,
      );
      user.value = result;
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await ServiceLocator.authService.forgotPassword(email: email);
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await ServiceLocator.authService.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    errorMessage.value = '';
    isLoading.value = true;
    try {
      await ServiceLocator.authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await ServiceLocator.authService.logout();
    user.value = null;
    driver.value = null;
    role.value = '';
  }
}
