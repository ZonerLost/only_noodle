import 'package:get/get.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class DriverHistoryController extends GetxController {
  final orders = <Order>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.driverService.getHistory();
      orders.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
