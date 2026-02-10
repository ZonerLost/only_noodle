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
    bool isDefault = false,
  }) async {
    if (label.trim().isEmpty ||
        street.trim().isEmpty ||
        city.trim().isEmpty ||
        zipCode.trim().isEmpty) {
      errorMessage.value = 'Please fill all required fields.';
      return;
    }
    final normalizedCountry = _normalizeCountry(country);
    if (normalizedCountry == null && country != null && country.trim().isNotEmpty) {
      errorMessage.value =
          'Country must be a 2-letter code (e.g., PK, DE).';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await ServiceLocator.userService.createAddress(
        label: label,
        street: street,
        city: city,
        zipCode: zipCode,
        country: normalizedCountry?.isEmpty == true ? null : normalizedCountry,
        deliveryInstructions: deliveryInstructions,
        isDefault: isDefault,
      );
      await loadAddresses();
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress({
    required String id,
    required String label,
    required String street,
    required String city,
    required String zipCode,
    String? country,
    String? deliveryInstructions,
    bool isDefault = false,
  }) async {
    if (label.trim().isEmpty ||
        street.trim().isEmpty ||
        city.trim().isEmpty ||
        zipCode.trim().isEmpty) {
      errorMessage.value = 'Please fill all required fields.';
      return;
    }
    final normalizedCountry = _normalizeCountry(country);
    if (normalizedCountry == null && country != null && country.trim().isNotEmpty) {
      errorMessage.value =
          'Country must be a 2-letter code (e.g., PK, DE).';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await ServiceLocator.userService.updateAddress(
        id: id,
        label: label,
        street: street,
        city: city,
        zipCode: zipCode,
        country: normalizedCountry?.isEmpty == true ? null : normalizedCountry,
        deliveryInstructions: deliveryInstructions,
        isDefault: isDefault,
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

  String? _normalizeCountry(String? country) {
    if (country == null || country.trim().isEmpty) return '';
    final trimmed = country.trim();
    if (trimmed.length != 2) return null;
    return trimmed.toUpperCase();
  }
}
