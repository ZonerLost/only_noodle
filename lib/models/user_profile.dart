class UserProfile {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String language;
  final String profilePicture;

  const UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.language,
    required this.profilePicture,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? json['fullName'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      language: (json['language'] ?? '').toString(),
      profilePicture: (json['profilePicture'] ?? json['imageUrl'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'language': language,
      'profilePicture': profilePicture,
    };
  }
}
