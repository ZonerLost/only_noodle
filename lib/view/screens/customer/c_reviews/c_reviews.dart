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
import 'package:only_noodle/controllers/reviews_controller.dart';

class CReviews extends StatefulWidget {
  const CReviews({super.key, required this.restaurantId});

  final String restaurantId;

  @override
  State<CReviews> createState() => _CReviewsState();
}

class _CReviewsState extends State<CReviews> {
  late final ReviewsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      ReviewsController(widget.restaurantId),
      tag: widget.restaurantId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Restaurant Reviews'),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (_controller.reviews.isEmpty) {
            return Center(
              child: MyText(
                text: 'No reviews yet.',
                color: kQuaternaryColor,
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            physics: BouncingScrollPhysics(),
            padding: AppSizes.DEFAULT,
            shrinkWrap: true,
            itemCount: _controller.reviews.length,
            itemBuilder: (context, idx) {
              final review = _controller.reviews[idx];
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
                                  text: (review['userName'] ?? 'Customer')
                                      .toString(),
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                                MyText(
                                  text: (review['createdAt'] ?? 'Recently')
                                      .toString(),
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
                            text:
                                '${review['rating'] ?? '-'} ratings',
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
                        text: (review['comment'] ??
                                'No comment provided.')
                            .toString(),
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
                        final commentController = TextEditingController();
                        return Column(
                          children: [
                            Center(
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
                                itemPadding: EdgeInsets.symmetric(horizontal: 5),
                                onRatingUpdate: (rating) =>
                                    ratingNotifier.value = rating,
                              ),
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
                            SimpleTextField(
                              hintText: 'Your Feedback',
                              maxLines: 4,
                              controller: commentController,
                            ),
                            SizedBox(height: 16),
                            MyButton(
                              buttonText: 'Submit',
                              onTap: () async {
                                final comment = commentController.text.trim();
                                if (comment.length < 10) {
                                  Get.snackbar(
                                    'Review',
                                    'Comment must be at least 10 characters.',
                                  );
                                  return;
                                }
                                await _controller.submitReview(
                                  rating: ratingNotifier.value,
                                  comment: comment,
                                );
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    ),
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
