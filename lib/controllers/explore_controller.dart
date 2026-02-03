import 'package:get/get.dart';
import 'package:only_noodle/models/restaurant.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class ExploreController extends GetxController {
  final restaurants = <Restaurant>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadExplore();
  }

  Future<void> loadExplore() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.restaurantService.getRestaurants();
      restaurants.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      await loadExplore();
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.restaurantService.searchRestaurants(query);
      restaurants.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> filterByCuisine(String cuisineType) async {
    final cleaned = cuisineType.trim();
    if (cleaned.isEmpty) {
      await loadExplore();
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.restaurantService.getRestaurants(
        cuisineType: cleaned,
      );
      if (list.isEmpty) {
        await loadExplore();
        errorMessage.value = 'No restaurants found for "$cleaned".';
        return;
      }
      restaurants.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyFilter(String tag) async {
    final cleaned = tag.trim();
    if (cleaned.isEmpty) {
      await loadExplore();
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      switch (cleaned) {
        case 'Italian':
          await filterByCuisine('Italian');
          return;
        case 'Sea Food':
          await filterByCuisine('Seafood');
          return;
        case 'Desi / Traditional':
          await filterByCuisine('Indian');
          return;
        case 'Fast Food':
          await filterByCuisine('Fast Food');
          return;
        case '5 star ratings':
          final list = await ServiceLocator.restaurantService.getRestaurants(
            sortBy: 'rating',
            sortOrder: 'desc',
          );
          restaurants.assignAll(list);
          return;
        default:
          final list = await ServiceLocator.restaurantService.getRestaurants(
            search: cleaned,
          );
          if (list.isEmpty) {
            await loadExplore();
            errorMessage.value = 'No restaurants found for "$cleaned".';
            return;
          }
          restaurants.assignAll(list);
      }
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
