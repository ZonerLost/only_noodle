import 'api_client.dart';
import 'endpoints/zone_endpoints.dart';

class ZoneService {
  ZoneService(this._client);

  final ApiClient _client;

  Future<List<Map<String, dynamic>>> getZones() async {
    final data = await _client.get(ZoneEndpoints.list);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList();
    }
    return [];
  }

  Future<Map<String, dynamic>?> validateAddress({
    required String street,
    required String city,
    required String zipCode,
  }) async {
    final data = await _client.post(
      ZoneEndpoints.validate,
      body: {
        'street': street,
        'city': city,
        'zipCode': zipCode,
      },
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }

  Future<Map<String, dynamic>?> checkDeliverable({
    required String street,
    required String city,
    required String zipCode,
  }) async {
    final data = await _client.get(
      ZoneEndpoints.check,
      query: {
        'street': street,
        'city': city,
        'zipCode': zipCode,
      },
    );
    if (data is Map<String, dynamic>) return data;
    return null;
  }
}
