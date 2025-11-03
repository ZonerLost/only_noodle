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

class CReviews extends StatelessWidget {
  const CReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Restaurant Reviews'),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        physics: BouncingScrollPhysics(),
        padding: AppSizes.DEFAULT,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, idx) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: kFillColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CommonImageView(
                        height: 40,
                        width: 40,
                        radius: 100,
                        url: dummyImg,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'Melisa Thomas',
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                            MyText(
                              text: '2 days ago',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(Assets.imagesStar, height: 16),
                      MyText(
                        paddingLeft: 4,
                        text: '4.7 ratings',
                        size: 14,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    color: kBorderColor,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  MyText(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    size: 12,
                    weight: FontWeight.w500,
                    color: kQuaternaryColor,
                    lineHeight: 1.5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: MyButton(
          buttonText: 'Write a Review',
          onTap: () {
            Get.bottomSheet(
              CustomDialog(
                height: Get.height * 0.54,
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
                          Image.asset(Assets.imagesArrowBack, height: 20),
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
                        final ratingNotifier = ValueNotifier<double>(4.0);
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
                              return Image.asset(Assets.imagesStar, height: 36);
                            },
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            onRatingUpdate: (rating) =>
                                ratingNotifier.value = rating,
                          ),
                        );
                      },
                    ),
                    MyText(
                      text: 'Write a Review',
                      size: 22,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      paddingTop: 12,
                    ),
                    MyText(
                      paddingTop: 8,
                      text:
                          'How was your experience with this restaurant. Feel free to share the feedback.',
                      color: kQuaternaryColor,
                      textAlign: TextAlign.center,
                      lineHeight: 1.5,
                      size: 14,
                      weight: FontWeight.w500,
                      paddingBottom: 16,
                    ),
                    SimpleTextField(hintText: 'Your Feedback', maxLines: 4),
                    SizedBox(height: 16),
                    MyButton(buttonText: 'Submit', onTap: () {}),
                  ],
                ),
              ),
              isScrollControlled: true,
            );
          },
        ),
      ),
    );
  }
}
