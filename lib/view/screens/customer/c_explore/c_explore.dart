import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_home/c_restaurant_details.dart';
import 'package:only_noodle/view/screens/customer/c_reviews/c_reviews.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CExplore extends StatelessWidget {
  const CExplore({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Fast Food',
      'Lunch',
      'Dinner',
      'Italian',
      'Sea Food',
      'Desi / Traditional',
      '5 star ratings',
    ];
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 100,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              titleSpacing: 20.0,
              title: MyText(text: 'Explore', size: 16, weight: FontWeight.w500),
              flexibleSpace: Container(
                color: kPrimaryColor,
                child: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: AppSizes.HORIZONTAL,
                        child: SimpleTextField(
                          prefix: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.imagesSearch, height: 20),
                            ],
                          ),

                          hintText: 'Search your fav restaurants...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          padding: AppSizes.VERTICAL,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: AppSizes.HORIZONTAL,
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final title = categories[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? kSecondaryColor.withValues(alpha: 0.12)
                          : kFillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: MyText(
                        text: title,
                        size: 14,
                        color: index == 0 ? kSecondaryColor : kQuaternaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),

            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 12);
              },
              shrinkWrap: true,
              padding: AppSizes.DEFAULT,
              physics: BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Get.to(() => CRestaurantDetails()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kFillColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: CommonImageView(
                                height: 140,
                                radius: 0,
                                width: Get.width,
                                url: dummyImg,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Bottom overlay with details
                            Positioned(
                              left: 12,
                              right: 12,
                              top: 12,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.5,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kFillColor,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                Assets.imagesTime,
                                                height: 12,
                                              ),
                                              SizedBox(width: 4),
                                              MyText(
                                                text: '15 mins',
                                                size: 10,
                                                paddingRight: 4,
                                                weight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.5,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kGreenColor,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                Assets.imagesDiscount,
                                                height: 12,
                                              ),
                                              SizedBox(width: 4),
                                              MyText(
                                                text:
                                                    '25% discount on all items',
                                                size: 10,
                                                color: kFillColor,
                                                paddingRight: 4,
                                                weight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(Assets.imagesHear, height: 32),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 4,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'The Spice Room',
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                    MyText(
                                      text: '1.8 km  |  \$10 Delivery fee',
                                      size: 12,
                                      color: kQuaternaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(Assets.imagesStar, height: 14),
                              MyText(
                                text: '4.7',
                                paddingLeft: 2,
                                size: 12,
                                paddingRight: 4,
                              ),
                              Container(
                                width: 1,
                                height: 18,
                                color: Color(0xffE3E3E3),
                              ),
                              MyText(
                                onTap: () {
                                  Get.to(() => CReviews());
                                },
                                paddingLeft: 4,
                                text: '50k+ reviews',
                                weight: FontWeight.w500,
                                size: 12,
                                color: kSecondaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
