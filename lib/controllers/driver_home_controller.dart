import 'package:get/get.dart';
import 'package:only_noodle/models/driver_profile.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class DriverHomeController extends GetxController {
  final profile = Rxn<DriverProfile>();
  final orders = <Order>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDriverHome();
  }

  Future<void> loadDriverHome() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      profile.value = await ServiceLocator.driverService.getProfile();
      final list = await ServiceLocator.driverService.getAvailableOrders();
      orders.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
