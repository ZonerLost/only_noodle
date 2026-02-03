import 'package:get/get.dart';
import 'package:only_noodle/models/category.dart';
import 'package:only_noodle/models/restaurant.dart';
import 'package:only_noodle/models/user_profile.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class CustomerHomeController extends GetxController {
  final user = Rxn<UserProfile>();
  final categories = <Category>[].obs;
  final restaurants = <Restaurant>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadHome();
  }

  Future<void> loadHome() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      String? firstError;
      try {
        final profile = await ServiceLocator.userService.getProfile();
        user.value = profile;
      } on ApiException catch (error) {
        firstError ??= error.message;
      }
      try {
        final catList = await ServiceLocator.categoryService.getCategories();
        categories.assignAll(catList);
      } on ApiException catch (error) {
        firstError ??= error.message;
      }
      try {
        final list = await ServiceLocator.restaurantService.getRestaurants();
        restaurants.assignAll(list);
      } on ApiException catch (error) {
        firstError ??= error.message;
      }
      if (firstError != null) {
        errorMessage.value = firstError;
      }
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
