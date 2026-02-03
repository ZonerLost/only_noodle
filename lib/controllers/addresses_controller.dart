import 'package:get/get.dart';
import 'package:only_noodle/models/address.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class AddressesController extends GetxController {
  final addresses = <Address>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final list = await ServiceLocator.userService.getAddresses();
      addresses.assignAll(list);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createAddress({
    required String label,
    required String street,
    required String city,
    required String zipCode,
    String? country,
    String? deliveryInstructions,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await ServiceLocator.userService.createAddress(
        label: label,
        street: street,
        city: city,
        zipCode: zipCode,
        country: country,
        deliveryInstructions: deliveryInstructions,
      );
      await loadAddresses();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(String id) async {
    await ServiceLocator.userService.deleteAddress(id);
    await loadAddresses();
  }

  Future<void> setDefault(String id) async {
    await ServiceLocator.userService.setDefaultAddress(id);
    await loadAddresses();
  }
}
