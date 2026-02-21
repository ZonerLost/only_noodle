class DriverProfile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String vehicleType;
  final String licensePlate;
  final bool isOnline;

  const DriverProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.vehicleType,
    required this.licensePlate,
    required this.isOnline,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    final status = json['status']?.toString();
    final isOnlineValue = json['isOnline'];
    final bool isOnline = isOnlineValue is bool
        ? isOnlineValue
        : (status != null && status.isNotEmpty && status != 'inactive');
    return DriverProfile(
      id: (json['id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      vehicleType: (json['vehicleType'] ?? '').toString(),
      licensePlate: (json['licensePlate'] ?? '').toString(),
      isOnline: isOnline,
    );
  }
}
