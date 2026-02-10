import '../models/address.dart';
import '../models/user_profile.dart';
import 'api_client.dart';
import 'endpoints/user_endpoints.dart';

class UserService {
  UserService(this._client);

  final ApiClient _client;

  Future<UserProfile> getProfile() async {
    final data = await _client.get(UserEndpoints.me);
    if (data is Map<String, dynamic>) {
      return UserProfile.fromJson(data);
    }
    throw Exception('Invalid profile response');
  }

  Future<UserProfile> updateProfile({
    String? name,
    String? phone,
    String? language,
  }) async {
    final data = await _client.patch(
      UserEndpoints.me,
      body: {
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (language != null) 'language': language,
      },
    );
    if (data is Map<String, dynamic>) {
      return UserProfile.fromJson(data);
    }
    throw Exception('Invalid profile response');
  }

  Future<List<Address>> getAddresses() async {
    final data = await _client.get(UserEndpoints.addresses);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(Address.fromJson).toList();
    }
    return [];
  }

  Future<Address> createAddress({
    required String label,
    required String street,
    required String city,
    required String zipCode,
    String? country,
    double? lat,
    double? lng,
    bool isDefault = false,
    String? deliveryInstructions,
  }) async {
    final completeAddress = [
      street,
      city,
      zipCode,
      if (country != null) country,
    ].where((value) => value.trim().isNotEmpty).join(', ');
    final data = await _client.post(
      UserEndpoints.addresses,
      body: {
        'title': label,
        'label': label,
        'street': street,
        'city': city,
        'state': city,
        'zipCode': zipCode,
        'completeAddress': completeAddress,
        if (country != null) 'country': country,
        if (lat != null || lng != null)
          'coordinates': {
            if (lat != null) 'lat': lat,
            if (lng != null) 'lng': lng,
          },
        'isDefault': isDefault,
        if (deliveryInstructions != null) 'deliveryInstructions': deliveryInstructions,
      },
    );
    if (data is Map<String, dynamic>) {
      return Address.fromJson(data);
    }
    throw Exception('Invalid address response');
  }

  Future<Address> updateAddress({
    required String id,
    String? label,
    String? street,
    String? city,
    String? zipCode,
    String? country,
    bool? isDefault,
    String? deliveryInstructions,
  }) async {
    final completeAddress = [
      street ?? '',
      city ?? '',
      zipCode ?? '',
      country ?? '',
    ].where((value) => value.trim().isNotEmpty).join(', ');
    final data = await _client.patch(
      UserEndpoints.addressById(id),
      body: {
        if (label != null) 'title': label,
        if (label != null) 'label': label,
        if (street != null) 'street': street,
        if (city != null) 'city': city,
        if (city != null) 'state': city,
        if (zipCode != null) 'zipCode': zipCode,
        if (completeAddress.isNotEmpty) 'completeAddress': completeAddress,
        if (country != null) 'country': country,
        if (isDefault != null) 'isDefault': isDefault,
        if (deliveryInstructions != null) 'deliveryInstructions': deliveryInstructions,
      },
    );
    if (data is Map<String, dynamic>) {
      return Address.fromJson(data);
    }
    throw Exception('Invalid address response');
  }

  Future<void> deleteAddress(String id) async {
    await _client.delete(UserEndpoints.addressById(id));
  }

  Future<void> setDefaultAddress(String id) async {
    await _client.patch(UserEndpoints.defaultAddress(id));
  }
}
