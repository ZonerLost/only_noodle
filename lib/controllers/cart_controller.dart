import 'package:get/get.dart';
import 'package:only_noodle/models/cart.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class CartController extends GetxController {
  final cart = Rxn<Cart>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      cart.value = await ServiceLocator.cartService.getCart();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> increaseItem(String itemId, int currentQty) async {
    await _updateItem(itemId, currentQty + 1);
  }

  Future<void> decreaseItem(String itemId, int currentQty) async {
    final next = currentQty - 1;
    if (next <= 0) {
      await removeItem(itemId);
    } else {
      await _updateItem(itemId, next);
    }
  }

  Future<void> _updateItem(String itemId, int quantity) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      cart.value = await ServiceLocator.cartService.updateItem(
        itemId: itemId,
        quantity: quantity,
      );
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeItem(String itemId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      cart.value = await ServiceLocator.cartService.removeItem(itemId);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }
}
