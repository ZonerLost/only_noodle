import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_cart/c_cart.dart';
import 'package:only_noodle/view/screens/customer/c_home/c_restaurant_details.dart';
import 'package:only_noodle/view/screens/customer/c_reviews/c_reviews.dart';
import 'package:only_noodle/view/screens/customer/c_search/c_search.dart';
import 'package:only_noodle/view/screens/driver/d_home/d_order_details.dart';
import 'package:only_noodle/view/screens/notifications/c_notifications.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CHome extends StatelessWidget {
  const CHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 190,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              titleSpacing: 20.0,
              leadingWidth: 62,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: 'Welcome Back!',
                    color: kQuaternaryColor,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                  MyText(
                    paddingTop: 2,
                    text: 'Christopher Henry',
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
              actions: [
                Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => CCart()),
                    child: Image.asset(Assets.imagesCart, height: 32),
                  ),
                ),
                SizedBox(width: 10),
                Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => CNotifications()),
                    child: Image.asset(Assets.imagesNotification, height: 32),
                  ),
                ),
                SizedBox(width: 20),
              ],
              flexibleSpace: Container(
                color: kPrimaryColor,
                child: FlexibleSpaceBar(
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: AppSizes.HORIZONTAL,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MyText(
                              text: 'What would\nyou like to eat today?',
                              size: 24,
                              weight: FontWeight.w500,
                              paddingBottom: 16,
                            ),
                            SimpleTextField(
                              onTap: () {
                                Get.to(() => CSearch());
                              },
                              isReadOnly: true,
                              prefix: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Assets.imagesSearch, height: 20),
                                ],
                              ),
                              suffix: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(
                                        _Filter(),
                                        isScrollControlled: true,
                                      );
                                    },
                                    child: Image.asset(
                                      Assets.imagesFilter,
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                              hintText: 'Search your fav restaurants...',
                            ),
                          ],
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
            Container(
              margin: AppSizes.HORIZONTAL,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(Assets.imagesBanner),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: 'Order your favorite\nmeals in just a few taps!',
                    size: 18,
                    weight: FontWeight.w500,
                    paddingBottom: 8,
                  ),
                  SizedBox(
                    width: 100,
                    child: MyButton(
                      height: 38,
                      textSize: 12,
                      buttonText: 'Order Now',
                      onTap: () => Get.to(() => DOrderDetails()),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: 'Popular Categories',
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                  MyText(
                    text: 'View all >',
                    weight: FontWeight.w500,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ),
            GridView.builder(
              padding: AppSizes.HORIZONTAL,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                mainAxisExtent: 56,
                crossAxisSpacing: 4,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                final List<Map<String, String>> categories = [
                  {'title': 'Breakfast', 'image': Assets.imagesBreakfast},
                  {'title': 'Lunch', 'image': Assets.imagesLunch},
                  {'title': 'Dinner', 'image': Assets.imagesDinner},
                  {'title': 'Desserts', 'image': Assets.imagesDessert},
                ];
                final item = categories[index % categories.length];
                return Container(
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item['image']!,
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: MyText(
                          text: item['title']!,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                      Image.asset(Assets.imagesArrowNext, height: 20),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: MyText(
                      text: 'Restaurants near me',
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                  ),
                  MyText(
                    text: 'View all >',
                    weight: FontWeight.w500,
                    color: kSecondaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 230,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(width: 12);
                },
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: AppSizes.HORIZONTAL,
                physics: BouncingScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.to(() => CRestaurantDetails()),
                    child: Container(
                      width: 315,
                      decoration: BoxDecoration(
                        color: kFillColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: CommonImageView(
                                    width: Get.width,
                                    radius: 0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                      Image.asset(
                                        Assets.imagesHear,
                                        height: 32,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
            ),
          ],
        ),
      ),
    );
  }
}

class _Filter extends StatefulWidget {
  const _Filter();

  @override
  State<_Filter> createState() => _FilterState();
}

class _FilterState extends State<_Filter> {
  final List<String> _ratings = ['1 star', '2 star', '3 star', '5 star'];
  final List<String> _times = ['60 mins', '90 mins', '120 mins'];
  final List<String> _distances = ['500 m', '2.5 km', '5 km', '10 km +'];

  int _selectedRating = -1;
  int _selectedTime = -1;
  int _selectedDistance = -1;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: Get.height * 0.73,
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
                MyText(text: 'Back', size: 14, weight: FontWeight.w500),
              ],
            ),
          ),
          SizedBox(height: 10),
          MyText(
            text: 'Select Filters',
            size: 18,
            weight: FontWeight.w500,
            paddingTop: 12,
          ),
          MyText(
            paddingTop: 8,
            text: 'Please select the filters as per your preferences.',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            weight: FontWeight.w500,
          ),
          Container(
            height: 1,
            color: kBorderColor,
            margin: EdgeInsets.symmetric(vertical: 12),
          ),
          MyText(
            text: 'Search restaurants',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            weight: FontWeight.w500,
            paddingBottom: 8,
          ),
          SimpleTextField(
            hintText: 'Search...',
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesSearch, height: 20)],
            ),
          ),
          MyText(
            paddingTop: 16,
            text: 'Ratings',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            weight: FontWeight.w500,
            paddingBottom: 8,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppSizes.ZERO,
              physics: BouncingScrollPhysics(),
              itemCount: _ratings.length,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final title = _ratings[index];
                final selected = index == _selectedRating;
                return GestureDetector(
                  onTap: () => setState(() => _selectedRating = index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? kSecondaryColor.withValues(alpha: 0.12)
                          : kFillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      spacing: 4,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(Assets.imagesStar, height: 14),
                        MyText(
                          paddingRight: 4,
                          text: title,
                          size: 14,
                          color: selected ? kSecondaryColor : kTertiaryColor,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          MyText(
            paddingTop: 16,
            text: 'Delivery Time',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            weight: FontWeight.w500,
            paddingBottom: 8,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppSizes.ZERO,
              physics: BouncingScrollPhysics(),
              itemCount: _times.length,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final title = _times[index];
                final selected = index == _selectedTime;
                return GestureDetector(
                  onTap: () => setState(() => _selectedTime = index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? kSecondaryColor.withValues(alpha: 0.12)
                          : kFillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: MyText(
                        text: title,
                        size: 14,
                        color: selected ? kSecondaryColor : kTertiaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          MyText(
            paddingTop: 16,
            text: 'Distance',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            weight: FontWeight.w500,
            paddingBottom: 8,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppSizes.ZERO,
              physics: BouncingScrollPhysics(),
              itemCount: _distances.length,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemBuilder: (context, index) {
                final title = _distances[index];
                final selected = index == _selectedDistance;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDistance = index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? kSecondaryColor.withValues(alpha: 0.12)
                          : kFillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: MyText(
                        text: title,
                        size: 14,
                        color: selected ? kSecondaryColor : kTertiaryColor,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 30),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: MyButton(
                  radius: 12,
                  bgColor: kFillColor,
                  textColor: kQuaternaryColor,
                  buttonText: 'Reset',
                  textSize: 14,
                  onTap: () {
                    setState(() {
                      _selectedRating = -1;
                      _selectedTime = -1;
                      _selectedDistance = -1;
                    });
                  },
                ),
              ),
              Expanded(
                child: MyButton(
                  radius: 12,
                  textSize: 14,
                  buttonText: 'Apply Filters',
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
