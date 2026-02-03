class LoyaltyPoints {
  final int points;

  const LoyaltyPoints({required this.points});

  factory LoyaltyPoints.fromJson(Map<String, dynamic> json) {
    return LoyaltyPoints(points: (json['points'] as num?)?.toInt() ?? 0);
  }
}

class LoyaltyReward {
  final String id;
  final String title;
  final String description;
  final int requiredPoints;
  final bool isActive;

  const LoyaltyReward({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredPoints,
    required this.isActive,
  });

  factory LoyaltyReward.fromJson(Map<String, dynamic> json) {
    return LoyaltyReward(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      requiredPoints: (json['requiredPoints'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] == true,
    );
  }
}
