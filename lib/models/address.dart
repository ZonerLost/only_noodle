class Address {
  final String id;
  final String label;
  final String street;
  final String city;
  final String zipCode;
  final String country;
  final double? lat;
  final double? lng;
  final bool isDefault;
  final String deliveryInstructions;

  const Address({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.deliveryInstructions,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    final coordinates = json['coordinates'] as Map<String, dynamic>?;
    return Address(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      label: (json['label'] ?? json['title'] ?? '').toString(),
      street: (json['street'] ?? '').toString(),
      city: (json['city'] ?? json['state'] ?? '').toString(),
      zipCode: (json['zipCode'] ?? json['zip'] ?? json['postalCode'] ?? '')
          .toString(),
      country: (json['country'] ?? json['countryCode'] ?? '').toString(),
      lat: coordinates == null ? null : (coordinates['lat'] as num?)?.toDouble(),
      lng: coordinates == null ? null : (coordinates['lng'] as num?)?.toDouble(),
      isDefault: json['isDefault'] == true,
      deliveryInstructions: (json['deliveryInstructions'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'street': street,
      'city': city,
      'zipCode': zipCode,
      'country': country,
      'coordinates': {
        'lat': lat,
        'lng': lng,
      },
      'isDefault': isDefault,
      'deliveryInstructions': deliveryInstructions,
    };
  }

  String get displayLine {
    final parts = [street, city, zipCode].where((p) => p.isNotEmpty).toList();
    return parts.join(', ');
  }
}
