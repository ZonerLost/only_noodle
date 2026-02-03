import 'package:get/get.dart';
import 'package:only_noodle/models/category.dart';
import 'package:only_noodle/models/product.dart';
import 'package:only_noodle/models/restaurant.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class RestaurantDetailsController extends GetxController {
  RestaurantDetailsController(this.restaurantId);

  final String restaurantId;
  final restaurant = Rxn<Restaurant>();
  final categories = <Category>[].obs;
  final allProducts = <Product>[].obs;
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final cartItemCount = 0.obs;
  final cartTotal = 0.0.obs;
  final selectedCategoryId = RxnString();
  final selectedCategoryName = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future<void> loadDetails() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final details = await ServiceLocator.restaurantService.getRestaurant(restaurantId);
      restaurant.value = details;
      final menu = await ServiceLocator.restaurantService.getMenu(restaurantId);
      categories.assignAll(menu.categories);
      allProducts.assignAll(menu.products);
      if (categories.isNotEmpty) {
        applyCategory(categories.first);
      } else {
        applyCategory(null);
      }
      await loadCartSummary();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> addToCart(Product product, {int quantity = 1}) async {
    try {
      final selectedOptions = product.options
          .where((option) => option.required && option.choices.isNotEmpty)
          .map((option) {
            final choice = option.choices.first;
            return {'name': option.name, 'choice': choice.name};
          })
          .toList();
      final cart = await ServiceLocator.cartService.addItem(
        productId: product.id,
        restaurantId: restaurantId,
        quantity: quantity,
        selectedOptions: selectedOptions.isEmpty ? null : selectedOptions,
      );
      if (cart == null) {
        return 'Unable to add item. Please try again.';
      }
      await loadCartSummary();
      return null;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return error.message;
    } catch (_) {
      return 'Unexpected error. Please try again.';
    }
  }

  void applyCategory(Category? category) {
    selectedCategoryId.value = category?.id;
    selectedCategoryName.value = category?.name;
    if (category == null) {
      products.assignAll(allProducts);
      return;
    }
    final selectedId = category.id;
    final selectedName = category.name.toLowerCase();
    final filtered = allProducts.where((product) {
      if (selectedId.isNotEmpty && product.categoryId == selectedId) {
        return true;
      }
      if (selectedName.isNotEmpty &&
          product.categoryId.toLowerCase() == selectedName) {
        return true;
      }
      return false;
    }).toList();
    products.assignAll(filtered);
  }

  Future<void> loadCartSummary() async {
    final cart = await ServiceLocator.cartService.getCart();
    if (cart == null) {
      cartItemCount.value = 0;
      cartTotal.value = 0;
      return;
    }
    cartItemCount.value = cart.items.fold(0, (sum, item) => sum + item.quantity);
    cartTotal.value = cart.subtotal - cart.discount;
  }
}
