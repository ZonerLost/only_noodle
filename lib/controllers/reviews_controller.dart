import 'package:get/get.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class ReviewsController extends GetxController {
  ReviewsController(this.restaurantId);

  final String restaurantId;
  final reviews = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadReviews();
  }

  Future<void> loadReviews() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.restaurantService.getReviews(restaurantId);
      reviews.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitReview({
    required double rating,
    String? comment,
  }) async {
    errorMessage.value = '';
    try {
      final normalized = rating.round().clamp(1, 5).toDouble();
      await ServiceLocator.restaurantService.createReview(
        id: restaurantId,
        rating: normalized,
        comment: comment,
      );
      await loadReviews();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      Get.snackbar('Review', error.message);
      rethrow;
    }
  }
}
