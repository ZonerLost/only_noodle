import 'address.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final List<String> cuisineType;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String deliveryTime;
  final double deliveryFee;
  final double minimumOrder;
  final bool isOpen;
  final Address? address;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.cuisineType,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.isOpen,
    required this.address,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final coords = json['coordinates'] as Map<String, dynamic>?;
    final addressValue = json['address'];
    return Restaurant(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      cuisineType: (json['cuisineType'] as List? ??
              json['cuisineTypes'] as List? ??
              [])
          .map((e) => e.toString())
          .toList(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      deliveryTime: (json['deliveryTime'] ?? '').toString(),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0,
      minimumOrder: (json['minimumOrder'] as num?)?.toDouble() ?? 0,
      isOpen: json['isOpen'] == true,
      address: addressValue is Map<String, dynamic>
          ? Address.fromJson(addressValue)
          : addressValue is String
              ? Address(
                  id: '',
                  label: '',
                  street: addressValue,
                  city: '',
                  zipCode: '',
                  country: '',
                  lat: coords == null ? null : (coords['lat'] as num?)?.toDouble(),
                  lng: coords == null ? null : (coords['lng'] as num?)?.toDouble(),
                  isDefault: false,
                  deliveryInstructions: '',
                )
              : null,
    );
  }
}
