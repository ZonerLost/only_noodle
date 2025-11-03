import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_reviews/c_reviews.dart';
import 'package:only_noodle/view/screens/customer/c_search/c_search.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class CRestaurantDetails extends StatefulWidget {
  const CRestaurantDetails({super.key});

  @override
  State<CRestaurantDetails> createState() => _CRestaurantDetailsState();
}

class _CRestaurantDetailsState extends State<CRestaurantDetails> {
  int _selectedIndex = 0;
  final categories = ['All', 'Starter', 'Breakfast', 'Deserts', 'Deserts'];
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
              expandedHeight: 280,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              titleSpacing: 20.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Stack(
                    children: [
                      CommonImageView(
                        height: Get.height,
                        width: Get.width,
                        radius: 0,
                        fit: BoxFit.cover,
                        url: dummyImg,
                      ),
                      Container(
                        height: Get.height,
                        width: Get.width,
                        padding: EdgeInsets.fromLTRB(20, 55, 20, 0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kPrimaryColor.withValues(alpha: 0),
                              kPrimaryColor.withValues(alpha: 0.2),
                              kPrimaryColor.withValues(alpha: 1.0),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Image.asset(
                                    Assets.imagesArrowBackRounded,
                                    height: 46,
                                  ),
                                ),
                                Expanded(
                                  child: SimpleTextField(hintText: 'Search...'),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1.0,
                                      color: kFillColor,
                                    ),
                                  ),
                                  child: CommonImageView(
                                    height: 90,
                                    width: 90,
                                    radius: 12.0,
                                    url: dummyImg,
                                  ),
                                ),
                                MyText(
                                  paddingTop: 14,
                                  text: 'The Spice Room',
                                  size: 16,
                                  paddingBottom: 8,
                                  weight: FontWeight.w500,
                                ),
                                Row(
                                  children: [
                                    Image.asset(Assets.imagesStar, height: 14),
                                    MyText(
                                      text: '4.7',
                                      paddingLeft: 4,
                                      size: 14,
                                      paddingRight: 8,
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
                                      paddingLeft: 8,
                                      text: '50k+ reviews',
                                      weight: FontWeight.w500,
                                      size: 14,
                                      color: kSecondaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ],
                                ),
                              ],
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
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: AppSizes.VERTICAL,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: AppSizes.DEFAULT,
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '\$10 - \$100',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Price Range',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 22, color: kBorderColor),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '95%',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Satisfaction',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 22, color: kBorderColor),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '20 mins',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Time Delivery',
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
                Container(
                  margin: AppSizes.HORIZONTAL,
                  height: 44,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: List.generate(3, (index) {
                      final isSelected = _selectedIndex == index;
                      final labels = ['All items', 'Popular', 'Discounts'];
                      final label = labels[index % labels.length];
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? kSecondaryColor.withValues(alpha: .12)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: MyText(
                                text: label,
                                weight: FontWeight.w500,
                                color: isSelected
                                    ? kSecondaryColor
                                    : kQuaternaryColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                MyText(
                  paddingLeft: 20,
                  paddingRight: 20,
                  text: 'All items in Cheezy Bite',
                  paddingTop: 12,
                  paddingBottom: 8,
                  size: 16,
                  weight: FontWeight.w500,
                ),
                MyText(
                  paddingLeft: 20,
                  paddingRight: 20,
                  text: 'A full list of all the available items in the store.',
                  size: 12,
                  color: kQuaternaryColor,
                  weight: FontWeight.w500,
                  paddingBottom: 16,
                ),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: AppSizes.HORIZONTAL,
                    physics: BouncingScrollPhysics(),
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final title = categories[index];
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
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
                            color: index == 0
                                ? kSecondaryColor
                                : kQuaternaryColor,
                            weight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 14),
                GridView.builder(
                  padding: AppSizes.HORIZONTAL,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => CRestaurantDetails()),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kFillColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Stack(
                              children: [
                                CommonImageView(
                                  height: 130,
                                  radius: 16,
                                  width: Get.width,
                                  url: dummyImg,
                                  fit: BoxFit.cover,
                                ),

                                // Bottom overlay with details
                                Positioned(
                                  left: 8,
                                  top: 8,
                                  child: Row(
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
                                            10,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 4,
                                      children: [
                                        MyText(
                                          text: 'Zinger Burger',
                                          size: 14,
                                          maxLines: 1,
                                          textOverflow: TextOverflow.ellipsis,
                                          weight: FontWeight.w500,
                                        ),
                                        MyText(
                                          text: '\$199.00',
                                          size: 14,
                                          color: kQuaternaryColor,
                                          weight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    Assets.imagesAddRounded,
                                    height: 32,
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
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(_ItemDetails(), isScrollControlled: true);
                },
                child: Container(
                  height: 56,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFFF8A53), Color(0xFFF26523)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: kTertiaryColor.withValues(alpha: 0.16),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      MyText(
                        text: 'View your cart',
                        size: 16,
                        paddingRight: 6,
                        weight: FontWeight.w500,
                        color: kFillColor,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: kFillColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: MyText(
                                text: '4x',
                                size: 10,
                                weight: FontWeight.w500,
                                color: kSecondaryColor,
                              ),
                            ),
                            MyText(
                              text: '\$ 88.79',
                              size: 16,
                              weight: FontWeight.w600,
                              color: kFillColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: Get.height * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppSizes.ZERO,
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CommonImageView(
                      height: 200,
                      width: Get.width,
                      url: dummyImg,
                      radius: 16,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 48,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: kFillColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.imagesRemoveItem,
                            height: Get.height,
                          ),
                          Expanded(
                            child: MyText(
                              text: '01',
                              size: 18,
                              textAlign: TextAlign.center,
                              weight: FontWeight.w500,
                            ),
                          ),
                          Image.asset(Assets.imagesAddItem, height: Get.height),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: 'Zinger Burger',
                            size: 20,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            paddingBottom: 4,
                            weight: FontWeight.w500,
                          ),
                          Row(
                            children: [
                              Image.asset(Assets.imagesStar, height: 14),
                              MyText(
                                text: '4.7',
                                paddingLeft: 4,
                                size: 14,
                                paddingRight: 8,
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
                                paddingLeft: 8,
                                text: '50k+ reviews',
                                weight: FontWeight.w500,
                                size: 14,
                                color: kSecondaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MyText(
                      text: '\$199.00',
                      size: 20,
                      paddingBottom: 8,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 12),
                  padding: AppSizes.DEFAULT,
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '100 kcal',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Calories',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 22, color: kBorderColor),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '1 person',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Serving',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 22, color: kBorderColor),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                              text: '20 mins',
                              size: 14,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 2),
                            MyText(
                              text: 'Cooking Time',
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
                MyText(
                  text: 'Add-on',
                  weight: FontWeight.w500,
                  paddingBottom: 8,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 6);
                  },
                  physics: BouncingScrollPhysics(),
                  padding: AppSizes.ZERO,
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, sectionIndex) {
                    return _AddOnItem();
                  },
                ),
              ],
            ),
          ),
          MyButton(buttonText: 'Add to Cart', onTap: () {}),
        ],
      ),
    );
  }
}

class _AddOnItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kFillColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CommonImageView(height: 45, width: 45, radius: 8, url: dummyImg),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(text: 'Mayo Dip', size: 14, weight: FontWeight.w500),
                MyText(
                  text: '\$199.00',
                  size: 12,
                  weight: FontWeight.w500,
                  color: kQuaternaryColor,
                ),
              ],
            ),
          ),
          Image.asset(Assets.imagesAddRounded, height: 38),
        ],
      ),
    );
  }
}
