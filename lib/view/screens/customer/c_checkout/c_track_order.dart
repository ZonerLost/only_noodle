import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class CTrackOrder extends StatefulWidget {
  const CTrackOrder({super.key});

  @override
  State<CTrackOrder> createState() => _CTrackOrderState();
}

class _CTrackOrderState extends State<CTrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Track order'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kFillColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Assets.imagesReciept, height: 40),
                    MyText(
                      text: 'Order ID #SN-324',
                      size: 14,
                      weight: FontWeight.w500,
                      color: kQuaternaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                MyText(
                  text: 'Order is Preparing',
                  size: 18,
                  weight: FontWeight.w600,
                ),
                MyText(
                  paddingTop: 4,
                  text: 'Exp arriving time 09:30 pm',
                  size: 14,
                  color: kQuaternaryColor,
                  weight: FontWeight.w500,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 1,
                  color: kBorderColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    final steps = [
                      'Accepted',
                      'Processing',
                      'Pickup',
                      'Delivered',
                    ];
                    final stepLabel = steps[index];

                    return Column(
                      spacing: 6,
                      children: [
                        Image.asset(
                          index >= 2
                              ? Assets.imagesStepperIconEmpty
                              : Assets.imagesStepperIconFilled,
                          height: 28,
                        ),
                        MyText(
                          text: stepLabel,
                          size: 12,
                          weight: FontWeight.w500,
                          color: index <= 1 ? kTertiaryColor : kQuaternaryColor,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kFillColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.0, color: kFillColor),
                        ),
                        child: CommonImageView(
                          height: 30,
                          width: 30,
                          radius: 100.0,
                          url: dummyImg,
                        ),
                      ),
                      Expanded(
                        child: MyText(
                          paddingLeft: 8,
                          text: 'Christopher Henry',
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            CustomDialog(
                              image: Assets.imagesContact,
                              title: 'Contact Christopher',
                              subTitle:
                                  'You can contact them simple by calling on this number.',
                              actionButtons: MyButton(
                                buttonText: '',
                                bgColor: kFillColor,
                                radius: 12,
                                customChild: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MyText(
                                          text: 'Call + (91) 45645645 5',
                                          size: 12,
                                          weight: FontWeight.w500,
                                        ),
                                      ),
                                      Image.asset(
                                        Assets.imagesArrowNext,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ),
                            isScrollControlled: true,
                          );
                        },

                        child: Image.asset(Assets.imagesCall, height: 32),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  color: kBorderColor,
                ),
                MyText(
                  text: 'Order Items',
                  size: 12,
                  weight: FontWeight.w500,
                  color: kQuaternaryColor,
                ),
                ...List.generate(3, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        MyText(text: '1x', weight: FontWeight.w600),
                        Expanded(
                          child: MyText(
                            paddingLeft: 10,
                            text: ' Big Might Burger',
                            color: kQuaternaryColor,
                          ),
                        ),
                        MyText(text: '€', weight: FontWeight.w700),
                        MyText(text: '50.00', weight: FontWeight.w500),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: kFillColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(3, (index) {
              final List<Map<String, dynamic>> details = [
                {'title': 'Items Price', 'value': '500.00', 'currency': true},
                {'title': 'Total Price', 'value': '100.00', 'currency': true},
                {
                  'title': 'Payment Type',
                  'value': 'Cash on Delivery',
                  'currency': false,
                },
              ];

              final detail = details[index];
              final String title = detail['title'] as String;
              // Build the widget that shows the value; if currency is true,
              // show the currency symbol and the amount together.
              final Widget valueWidget = (detail['currency'] as bool)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(text: '€', weight: FontWeight.w700),
                        MyText(
                          text: detail['value'] as String,
                          weight: FontWeight.w500,
                        ),
                      ],
                    )
                  : MyText(
                      text: detail['value'] as String,
                      weight: FontWeight.w700,
                    );

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
                        valueWidget,
                      ],
                    ),
                  ),
                  // Divider between items (except after the last one)
                  if (index < details.length - 1)
                    index == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Image.asset(Assets.imagesDottedBorder),
                          )
                        : Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            color: kBorderColor,
                          ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
