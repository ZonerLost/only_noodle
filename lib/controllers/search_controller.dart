import 'package:get/get.dart';
import 'package:only_noodle/models/product.dart';
import 'package:only_noodle/models/restaurant.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class AppSearchController extends GetxController {
  final restaurants = <Restaurant>[].obs;
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      restaurants.clear();
      products.clear();
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final res = await ServiceLocator.restaurantService.searchRestaurants(trimmed);
      final pro = await ServiceLocator.productService.searchProducts(trimmed);
      restaurants.assignAll(res);
      products.assignAll(pro);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
