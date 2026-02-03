import 'package:get/get.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class OrderHistoryController extends GetxController {
  final orders = <Order>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.orderService.getOrders();
      orders.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitReview({
    required String orderId,
    required double rating,
    String? comment,
  }) async {
    await ServiceLocator.orderService.reviewOrder(
      id: orderId,
      rating: rating,
      comment: comment,
    );
    await loadOrders();
  }
}
