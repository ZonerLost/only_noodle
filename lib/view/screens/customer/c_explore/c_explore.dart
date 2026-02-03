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
import 'package:get/get.dart';
import 'package:only_noodle/controllers/explore_controller.dart';

class CExplore extends StatefulWidget {
  const CExplore({super.key, this.initialQuery, this.initialCuisine});

  final String? initialQuery;
  final String? initialCuisine;

  @override
  State<CExplore> createState() => _CExploreState();
}

class _CExploreState extends State<CExplore> {
  late final ExploreController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ExploreController());
    final query = widget.initialQuery?.trim();
    final cuisine = widget.initialCuisine?.trim();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (cuisine != null && cuisine.isNotEmpty) {
        _controller.filterByCuisine(cuisine);
        return;
      }
      if (query != null && query.isNotEmpty) {
        _controller.search(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
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
                          onChanged: (value) => controller.search(value),
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
            Obx(
              () => controller.errorMessage.value.isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: AppSizes.HORIZONTAL,
                      child: MyText(
                        text: controller.errorMessage.value,
                        size: 12,
                        color: Colors.red,
                      ),
                    ),
            ),
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
                  final selected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedIndex = index);
                      controller.applyFilter(title);
                    },
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
                          color:
                              selected ? kSecondaryColor : kQuaternaryColor,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                final list = controller.restaurants;
                if (list.isEmpty) {
                  return Padding(
                    padding: AppSizes.HORIZONTAL,
                    child: MyText(
                      text: 'No restaurants found.',
                      size: 12,
                      color: kQuaternaryColor,
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  shrinkWrap: true,
                  padding: AppSizes.DEFAULT,
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final restaurant = list[index];
                    return GestureDetector(
                      onTap: () => Get.to(
                        () => CRestaurantDetails(
                          restaurantId: restaurant.id,
                        ),
                      ),
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
                                    url: restaurant.imageUrl.isNotEmpty
                                        ? restaurant.imageUrl
                                        : dummyImg,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                                    text: restaurant
                                                            .deliveryTime.isNotEmpty
                                                        ? restaurant.deliveryTime
                                                        : 'N/A',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: restaurant.name,
                                          size: 14,
                                          weight: FontWeight.w500,
                                        ),
                                        MyText(
                                          text:
                                              'EUR ${restaurant.deliveryFee.toStringAsFixed(2)} Delivery fee',
                                          size: 12,
                                          color: kQuaternaryColor,
                                          weight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(Assets.imagesStar, height: 14),
                                  MyText(
                                    text: restaurant.rating.toStringAsFixed(1),
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
                                      Get.to(
                                        () => CReviews(
                                          restaurantId: restaurant.id,
                                        ),
                                      );
                                    },
                                    paddingLeft: 4,
                                    text:
                                        '${restaurant.reviewCount} reviews',
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
