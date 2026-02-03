import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/models/order.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_track_order.dart';
import 'package:only_noodle/view/screens/customer/c_nav_bar/c_nav_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class COrderConfirmed extends StatelessWidget {
  const COrderConfirmed({super.key, required this.order});

  final Order order;

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
                  'Congratulation! You order has been placed successfully and you will receive a confirmation email and our delivery rider will call you shortly.',
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
                  {
                    'title': 'Date & Time',
                    'value': order.createdAt?.toIso8601String() ?? 'N/A',
                  },
                  {
                    'title': 'Exp Delivery Time',
                    'value': order.estimatedDeliveryTime?.toIso8601String() ?? 'N/A',
                  },
                  {
                    'title': 'Order Type',
                    'value': order.type,
                  },
                  {
                    'title': 'Total price',
                    'value': 'EUR ${order.total.toStringAsFixed(2)}',
                  },
                  {
                    'title': 'Payment Method Used',
                    'value': order.paymentMethod.isNotEmpty
                        ? order.paymentMethod
                        : 'Cash',
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
                  ],
                );
              },
            ),
            SizedBox(height: 40),
            MyButton(
              buttonText: 'Track order',
              onTap: () {
                Get.to(() => CTrackOrder(orderId: order.id));
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