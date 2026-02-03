import '../models/order.dart';
import 'api_client.dart';
import 'endpoints/order_endpoints.dart';

class OrderService {
  OrderService(this._client);

  final ApiClient _client;

  Future<Order> createOrder({
    required String type,
    required String paymentMethod,
    String? addressId,
    String? pickupTime,
    String? paymentIntentId,
    double tip = 0,
    String? notes,
    String? selectedBonusId,
  }) async {
    final data = await _client.post(
      OrderEndpoints.orders,
      body: {
        'type': type,
        'paymentMethod': paymentMethod,
        if (addressId != null) 'addressId': addressId,
        if (pickupTime != null) 'pickupTime': pickupTime,
        if (paymentIntentId != null) 'paymentIntentId': paymentIntentId,
        'tip': tip,
        if (notes != null) 'notes': notes,
        if (selectedBonusId != null) 'selectedBonusId': selectedBonusId,
      },
    );
    if (data is Map<String, dynamic>) {
      return Order.fromJson(data);
    }
    throw Exception('Invalid order response');
  }

  Future<List<Order>> getOrders() async {
    final data = await _client.get(OrderEndpoints.orders);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Order.fromJson).toList();
    }
    return [];
  }

  Future<Order> getOrder(String id) async {
    final data = await _client.get(OrderEndpoints.orderById(id));
    if (data is Map<String, dynamic>) {
      return Order.fromJson(data);
    }
    throw Exception('Invalid order response');
  }

  Future<Map<String, dynamic>?> trackOrder(String id) async {
    final data = await _client.get(OrderEndpoints.track(id));
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  Future<void> cancelOrder(String id, {String? reason}) async {
    await _client.post(
      OrderEndpoints.cancel(id),
      body: {if (reason != null) 'reason': reason},
    );
  }

  Future<void> reviewOrder({
    required String id,
    required double rating,
    String? comment,
  }) async {
    await _client.post(
      OrderEndpoints.review(id),
      body: {
        'rating': rating,
        if (comment != null) 'comment': comment,
      },
    );
  }

  Future<Order> reorder(String id) async {
    final data = await _client.post(OrderEndpoints.reorder(id));
    if (data is Map<String, dynamic>) {
      return Order.fromJson(data);
    }
    throw Exception('Invalid reorder response');
  }
}
