import 'package:get/get.dart';
import 'package:only_noodle/models/user_profile.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class ProfileController extends GetxController {
  final profile = Rxn<UserProfile>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      profile.value = await ServiceLocator.userService.getProfile();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? language,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      profile.value = await ServiceLocator.userService.updateProfile(
        name: name,
        phone: phone,
        language: language,
      );
      return true;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
