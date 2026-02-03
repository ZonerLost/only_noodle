import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:only_noodle/controllers/loyalty_controller.dart';

class LoyaltyRewards extends StatelessWidget {
  const LoyaltyRewards({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoyaltyController());
    return Scaffold(
      appBar: simpleAppBar(title: 'Loyalty Rewards'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: kFillColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: '${controller.points.value} pts',
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(height: 6),
                        MyText(
                          text: 'Available loyalty points',
                          size: 12,
                          color: kQuaternaryColor,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyText(
            text: 'REWARDS',
            size: 12,
            letterSpacing: 1.0,
            weight: FontWeight.w500,
            color: kQuaternaryColor,
            paddingTop: 18,
            paddingBottom: 12,
          ),
          Obx(
            () {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.rewards.isEmpty) {
                return MyText(
                  text: 'No rewards available.',
                  color: kQuaternaryColor,
                );
              }
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: AppSizes.ZERO,
                shrinkWrap: true,
                itemCount: controller.rewards.length,
                itemBuilder: (context, idx) {
                  final reward = controller.rewards[idx];
                  return GestureDetector(
                    onTap: () => controller.redeem(reward.id),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                      decoration: BoxDecoration(
                        color: kFillColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: reward.title,
                                      size: 16,
                                      weight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 6),
                                    MyText(
                                      text: reward.description,
                                      size: 12,
                                      color: kQuaternaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                reward.isActive
                                    ? Assets.imagesCheck
                                    : Assets.imagesUncheck,
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
