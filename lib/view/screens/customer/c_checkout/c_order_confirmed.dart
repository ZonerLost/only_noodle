import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_track_order.dart';
import 'package:only_noodle/view/screens/customer/c_nav_bar/c_nav_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class COrderConfirmed extends StatelessWidget {
  const COrderConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(top: 55),
        height: Get.height,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border.all(width: 1.0, color: kInputBorderColor),
          borderRadius: BorderRadius.circular(24),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 10),
            Image.asset(Assets.imagesSuccess, height: 150),
            MyText(
              text: 'Order Confirmed',
              size: 24,
              weight: FontWeight.w500,
              textAlign: TextAlign.center,
              paddingTop: 20,
            ),
            MyText(
              paddingTop: 8,
              text:
                  'Congratulation! You order has been placed successfully and you’ll receive a confirmation email and our delivery rider will call you shortly',
              color: kQuaternaryColor,
              textAlign: TextAlign.center,
              lineHeight: 1.5,
              size: 14,
              weight: FontWeight.w500,
              paddingBottom: 30,
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => Container(
                height: 1,
                color: kBorderColor,
                margin: EdgeInsets.symmetric(vertical: 6),
              ),
              itemBuilder: (context, index) {
                final List<Map<String, dynamic>> details = [
                  {'title': 'Date & Time', 'value': 'Oct 23 | 12:00 PM'},
                  {'title': 'Exp Delivery Time', 'value': '90 mins'},
                  {'title': 'Order Type', 'value': 'Delivery'},
                  {'title': 'Total price', 'value': '500.00'},
                  {
                    'title': 'Payment Method Used',
                    'value': 'Master card ***56',
                  },
                ];

                final detail = details[index];
                final String title = detail['title'] as String;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyText(text: title, color: kQuaternaryColor),
                          ),
                          MyText(
                            text: detail['value'] as String,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    if (title == 'Subtotal')
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Image.asset(Assets.imagesDottedBorder),
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 40),
            MyButton(
              buttonText: 'Track order',
              onTap: () {
                Get.to(() => CTrackOrder());
              },
            ),
            SizedBox(height: 10),
            MyButton(
              buttonText: 'Go to Home page',
              onTap: () {
                Get.offAll(() => CBottomNavBar());
              },
              bgColor: kFillColor,
              textColor: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
