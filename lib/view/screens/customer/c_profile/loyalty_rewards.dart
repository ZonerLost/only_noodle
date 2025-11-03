import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class LoyaltyRewards extends StatelessWidget {
  const LoyaltyRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Loyalty Rewards'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
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
                        text: '3,454 pts',
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MyText(
                    text: 'Redeem',
                    size: 14,
                    weight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
              ],
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
          ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: AppSizes.ZERO,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, idx) {
              return GestureDetector(
                onTap: () {},
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
                                  text: 'Master Blaster',
                                  size: 16,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(height: 6),
                                MyText(
                                  text: 'Order up to \$50.00 and get 10 points',
                                  size: 12,
                                  color: kQuaternaryColor,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            idx == 0
                                ? Assets.imagesCheck
                                : Assets.imagesUncheck,
                            height: 20,
                          ),
                        ],
                      ),

                      if (idx != 0)
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.7,
                                borderRadius: BorderRadius.circular(50),
                                minHeight: 6,
                                backgroundColor: kPrimaryColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  kSecondaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            MyText(
                              text: '56%',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
