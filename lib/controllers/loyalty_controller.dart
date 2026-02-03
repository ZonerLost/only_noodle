import 'package:get/get.dart';
import 'package:only_noodle/models/loyalty.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/utils/error_handler.dart';

class LoyaltyController extends GetxController {
  final points = 0.obs;
  final rewards = <LoyaltyReward>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLoyalty();
  }

  Future<void> loadLoyalty() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final pointsData = await ServiceLocator.loyaltyService.getPoints();
      points.value = pointsData.points;
      final rewardList = await ServiceLocator.loyaltyService.getRewards();
      rewards.assignAll(rewardList);
    } on ApiException catch (error) {
      errorMessage.value = error.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> redeem(String rewardId) async {
    await ServiceLocator.loyaltyService.redeemReward(rewardId);
    await loadLoyalty();
  }
}
