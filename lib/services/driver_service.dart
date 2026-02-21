import '../models/driver_profile.dart';
import '../models/order.dart';
import 'api_client.dart';
import 'endpoints/driver_endpoints.dart';

class DriverService {
  DriverService(this._client);

  final ApiClient _client;

  Future<DriverProfile> getProfile() async {
    final data = await _client.get(DriverEndpoints.profile);
    if (data is Map<String, dynamic>) {
      return DriverProfile.fromJson(data);
    }
    throw Exception('Invalid driver profile response');
  }

  Future<DriverProfile> updateProfile({
    String? name,
    String? phone,
    String? vehicleType,
    String? licensePlate,
    bool? isOnline,
  }) async {
    final data = await _client.patch(
      DriverEndpoints.profile,
      body: {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (vehicleType != null) 'vehicleType': vehicleType,
        if (licensePlate != null) 'licensePlate': licensePlate,
        if (isOnline != null) 'isOnline': isOnline,
      },
    );
    if (data is Map<String, dynamic>) {
      return DriverProfile.fromJson(data);
    }
    throw Exception('Invalid driver profile response');
  }

  Future<List<Order>> getAvailableOrders({int page = 1, int limit = 20}) async {
    final data = await _client.get(
      DriverEndpoints.orders,
      query: {
        'type': 'available',
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Order.fromJson).toList();
    }
    return [];
  }

  Future<Order> getOrder(String id) async {
    final data = await _client.get(DriverEndpoints.orderById(id));
    if (data is Map<String, dynamic>) {
      return Order.fromJson(data);
    }
    throw Exception('Invalid driver order response');
  }

  Future<void> acceptOrder(String id) async {
    await _client.patch(DriverEndpoints.acceptOrder(id));
  }

  Future<void> updateOrderStatus(String id, String status) async {
    await _client.patch(
      DriverEndpoints.updateStatus(id),
      body: {'status': status},
    );
  }

  Future<List<Order>> getHistory({int page = 1, int limit = 20}) async {
    final data = await _client.get(
      DriverEndpoints.history,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Order.fromJson).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> getTipsSummary() async {
    final data = await _client.get(DriverEndpoints.tips);
    if (data is Map<String, dynamic>) {
      final summary = data['summary'];
      if (summary is Map<String, dynamic>) {
        return {
          'total': summary['totalTips'] ?? summary['periodTips'] ?? 0,
          'period': summary['periodTips'] ?? 0,
          'count': summary['count'] ?? 0,
          'raw': data,
        };
      }
      return data;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getStats() async {
    final data = await _client.get(DriverEndpoints.stats);
    if (data is Map<String, dynamic>) {
      return {
        'orders': data['deliveriesThisWeek'] ?? data['totalDeliveries'] ?? 0,
        'ordersMonth': data['deliveriesThisMonth'] ?? 0,
        'tipsWeek': data['tipsThisWeek'] ?? 0,
        'tipsMonth': data['tipsThisMonth'] ?? 0,
        'rating': data['rating'] ?? 0,
        'ratingCount': data['ratingCount'] ?? 0,
        'raw': data,
      };
    }
    return null;
  }

  Future<void> updateLocation({required double lat, required double lng}) async {
    await _client.patch(
      DriverEndpoints.location,
      body: {
        'lat': lat,
        'lng': lng,
      },
    );
  }
}
