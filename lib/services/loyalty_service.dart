import '../models/loyalty.dart';
import 'api_client.dart';
import 'endpoints/loyalty_endpoints.dart';

class LoyaltyService {
  LoyaltyService(this._client);

  final ApiClient _client;

  Future<LoyaltyPoints> getPoints() async {
    final data = await _client.get(LoyaltyEndpoints.points);
    if (data is Map<String, dynamic>) {
      return LoyaltyPoints.fromJson(data);
    }
    return const LoyaltyPoints(points: 0);
  }

  Future<List<LoyaltyReward>> getRewards() async {
    final data = await _client.get(LoyaltyEndpoints.rewards);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().map(LoyaltyReward.fromJson).toList();
    }
    return [];
  }

  Future<void> redeemReward(String rewardId) async {
    await _client.post(
      LoyaltyEndpoints.redeem,
      body: {'rewardId': rewardId},
    );
  }
}
