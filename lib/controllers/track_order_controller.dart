import 'package:get/get.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class TrackOrderController extends GetxController {
  TrackOrderController(this.orderId);

  final String orderId;
  final order = Rxn<Order>();
  final tracking = <String, dynamic>{}.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTracking();
  }

  Future<void> loadTracking() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      order.value = await ServiceLocator.orderService.getOrder(orderId);
      final track = await ServiceLocator.orderService.trackOrder(orderId);
      if (track != null) {
        tracking.assignAll(track);
      }
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
