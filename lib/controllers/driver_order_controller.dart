import 'package:get/get.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class DriverOrderController extends GetxController {
  DriverOrderController(this.orderId);

  final String orderId;
  final order = Rxn<Order>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrder();
  }

  Future<void> loadOrder() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      order.value = await ServiceLocator.driverService.getOrder(orderId);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptOrder() async {
    await ServiceLocator.driverService.acceptOrder(orderId);
    await loadOrder();
  }

  Future<void> updateStatus(String status) async {
    await ServiceLocator.driverService.updateOrderStatus(orderId, status);
    await loadOrder();
  }
}
