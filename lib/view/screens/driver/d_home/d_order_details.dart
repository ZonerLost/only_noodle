import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class DOrderDetails extends StatefulWidget {
  const DOrderDetails({super.key});

  @override
  State<DOrderDetails> createState() => _DOrderDetailsState();
}

class _DOrderDetailsState extends State<DOrderDetails> {
  bool _orderPicked = false;
  bool _markComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Order Details'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
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
                Row(
                  spacing: 8,
                  children: [
                    Image.asset(Assets.imagesLocation, height: 40),
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text:
                                'St3 , Office 456, Wilson Road, California, USA',
                            size: 13,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    MyText(
                      text: '2.3 km',
                      size: 14,
                      color: kQuaternaryColor,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withValues(alpha: 0.12),
                    border: Border(
                      left: BorderSide(color: kSecondaryColor, width: 2),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MyText(
                    text: 'Google Maps',
                    size: 12,
                    color: kSecondaryColor,
                    weight: FontWeight.w600,
                  ),
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
                                onTap: () {
                                  Get.back();
                                  Get.bottomSheet(
                                    CustomDialog(
                                      image: Assets.imagesOrderStarted,
                                      title: 'Order Started',
                                      subTitle:
                                          'You have started the order. Please pick up the food from the restaurant and deliver it to the customer\'s address within the time period.',
                                      actionButtons: MyButton(
                                        buttonText: 'Done',
                                        onTap: () {
                                          Get.back();
                                          setState(() {
                                            // When user confirms Done here, mark the order as completed
                                            // and clear the 'picked' flag.
                                            _orderPicked = false;
                                            _markComplete = true;
                                          });
                                        },
                                      ),
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
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
            SizedBox(height: 20),
            MyButton(
              buttonText: _markComplete
                  ? 'Mark as Completed'
                  : (_orderPicked ? 'Order Picked' : 'Start Order'),
              onTap: () {
                _markComplete
                    ? Get.bottomSheet(
                        CustomDialog(
                          height: Get.height * 0.57,

                          child: ListView(
                            shrinkWrap: true,
                            padding: AppSizes.ZERO,
                            physics: BouncingScrollPhysics(),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Row(
                                  spacing: 6,
                                  children: [
                                    Image.asset(
                                      Assets.imagesArrowBack,
                                      height: 20,
                                    ),
                                    MyText(
                                      text: 'Back',
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 28),

                              Builder(
                                builder: (context) {
                                  final ratingNotifier = ValueNotifier<double>(
                                    4.0,
                                  );
                                  return Center(
                                    child: RatingBar.builder(
                                      initialRating: ratingNotifier.value,
                                      minRating: 1,
                                      glow: false,
                                      allowHalfRating: true,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 36,
                                      unratedColor: kBorderColor,
                                      itemBuilder: (context, _) {
                                        return Image.asset(
                                          Assets.imagesStar,
                                          height: 36,
                                        );
                                      },
                                      itemPadding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      onRatingUpdate: (rating) =>
                                          ratingNotifier.value = rating,
                                    ),
                                  );
                                },
                              ),
                              MyText(
                                text: 'Submit Feedback',
                                size: 24,
                                weight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                paddingTop: 12,
                              ),
                              MyText(
                                paddingTop: 8,
                                text:
                                    'How was your experience with this order. Feel free to share the feedback regarding the customer behavior.',
                                color: kQuaternaryColor,
                                textAlign: TextAlign.center,
                                lineHeight: 1.5,
                                size: 16,
                                weight: FontWeight.w500,
                                paddingBottom: 16,
                              ),
                              SimpleTextField(
                                hintText: 'Your Feedback',
                                maxLines: 4,
                              ),
                              SizedBox(height: 16),
                              MyButton(buttonText: 'Submit', onTap: () {}),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      )
                    : Get.bottomSheet(
                        CustomDialog(
                          image: Assets.imagesOrderStarted,
                          title: 'Order Picked',
                          subTitle:
                              "You have picked up the food from the restaurant. Please deliver it to the given customer address. Don't forget to collect the payment.",
                          actionButtons: MyButton(
                            buttonText: 'Done',
                            onTap: () {
                              Get.back();
                              setState(() {
                                // User confirmed delivery pickup flow, now mark completed
                                _orderPicked = false;
                                _markComplete = true;
                              });
                            },
                          ),
                        ),
                        isScrollControlled: true,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
