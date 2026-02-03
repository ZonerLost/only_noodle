import 'package:get/get.dart';
import 'package:only_noodle/models/address.dart';
import 'package:only_noodle/models/cart.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class CheckoutController extends GetxController {
  final cart = Rxn<Cart>();
  final addresses = <Address>[].obs;
  final selectedAddressId = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final tipAmount = 0.0.obs;
  final discountCode = ''.obs;
  final totals = <String, dynamic>{}.obs;
  final latestOrder = Rxn<Order>();

  @override
  void onInit() {
    super.onInit();
    loadCheckoutData();
  }

  Future<void> loadCheckoutData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      cart.value = await ServiceLocator.cartService.getCart();
      final list = await ServiceLocator.userService.getAddresses();
      addresses.assignAll(list);
      Address? defaultAddress;
      for (final address in list) {
        if (address.isDefault) {
          defaultAddress = address;
          break;
        }
      }
      if (defaultAddress != null) {
        selectedAddressId.value = defaultAddress.id;
      } else if (list.isNotEmpty) {
        selectedAddressId.value = list.first.id;
      }
      await calculateTotals();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> calculateTotals() async {
    final addressId = selectedAddressId.value.isEmpty ? null : selectedAddressId.value;
    final data = await ServiceLocator.cartService.calculateTotals(
      tip: tipAmount.value,
      addressId: addressId,
    );
    if (data != null) {
      totals.assignAll(data);
    }
  }

  Future<void> setTip(double amount) async {
    tipAmount.value = amount;
    await calculateTotals();
  }

  Future<void> applyPromo(String code) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      discountCode.value = code;
      cart.value = await ServiceLocator.cartService.applyPromo(code);
      await calculateTotals();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Order?> createOrder({
    required String type,
    required String paymentMethod,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final order = await ServiceLocator.orderService.createOrder(
        type: type,
        paymentMethod: paymentMethod,
        addressId: selectedAddressId.value.isEmpty ? null : selectedAddressId.value,
        tip: tipAmount.value,
      );
      latestOrder.value = order;
      return order;
    } on ApiException catch (error) {
      errorMessage.value = error.message;
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
