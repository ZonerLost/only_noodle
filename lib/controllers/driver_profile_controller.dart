import 'package:get/get.dart';
import 'package:only_noodle/models/driver_profile.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class DriverProfileController extends GetxController {
  final profile = Rxn<DriverProfile>();
  final tipsSummary = <String, dynamic>{}.obs;
  final stats = <String, dynamic>{}.obs;
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
      profile.value = await ServiceLocator.driverService.getProfile();
      final tips = await ServiceLocator.driverService.getTipsSummary();
      if (tips != null) tipsSummary.assignAll(tips);
      final statsData = await ServiceLocator.driverService.getStats();
      if (statsData != null) stats.assignAll(statsData);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? vehicleType,
    String? licensePlate,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      profile.value = await ServiceLocator.driverService.updateProfile(
        name: name,
        phone: phone,
        vehicleType: vehicleType,
        licensePlate: licensePlate,
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
