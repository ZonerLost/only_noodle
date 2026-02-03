import '../models/cart.dart';
import 'api_client.dart';
import 'endpoints/cart_endpoints.dart';

class CartService {
  CartService(this._client);

  final ApiClient _client;

  Future<Cart?> getCart() async {
    final data = await _client.get(CartEndpoints.cart);
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<Cart?> addItem({
    required String productId,
    String? restaurantId,
    int quantity = 1,
    List<Map<String, dynamic>>? selectedOptions,
    List<Map<String, dynamic>>? selectedExtras,
    String? notes,
  }) async {
    final data = await _client.post(
      CartEndpoints.items,
      body: {
        'productId': productId,
        if (restaurantId != null) 'restaurantId': restaurantId,
        'quantity': quantity,
        if (selectedOptions != null) 'selectedOptions': selectedOptions,
        if (selectedExtras != null) 'selectedExtras': selectedExtras,
        if (notes != null) 'notes': notes,
      },
    );
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<Cart?> updateItem({
    required String itemId,
    int? quantity,
    List<Map<String, dynamic>>? selectedOptions,
    List<Map<String, dynamic>>? selectedExtras,
    String? notes,
  }) async {
    final data = await _client.patch(
      CartEndpoints.itemById(itemId),
      body: {
        if (quantity != null) 'quantity': quantity,
        if (selectedOptions != null) 'selectedOptions': selectedOptions,
        if (selectedExtras != null) 'selectedExtras': selectedExtras,
        if (notes != null) 'notes': notes,
      },
    );
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<Cart?> removeItem(String itemId) async {
    final data = await _client.delete(CartEndpoints.itemById(itemId));
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<void> clearCart() async {
    await _client.delete(CartEndpoints.cart);
  }

  Future<Map<String, dynamic>?> calculateTotals({
    double tip = 0,
    String? addressId,
  }) async {
    final data = await _client.post(
      CartEndpoints.calculate,
      body: {
        'tip': tip,
        if (addressId != null) 'addressId': addressId,
      },
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  Future<Cart?> applyPromo(String code) async {
    final data = await _client.post(
      CartEndpoints.applyPromo,
      body: {'code': code},
    );
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<Cart?> removePromo() async {
    final data = await _client.delete(CartEndpoints.removePromo);
    if (data is Map<String, dynamic>) {
      return Cart.fromJson(data);
    }
    return null;
  }

  Future<Map<String, dynamic>?> checkBonusEligibility() async {
    final data = await _client.get(CartEndpoints.bonusEligibility);
    if (data is Map<String, dynamic>) return data;
    return null;
  }
}
