import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/controllers/search_controller.dart';
import 'package:only_noodle/view/screens/customer/c_home/c_restaurant_details.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class CSearch extends StatefulWidget {
  const CSearch({super.key});

  @override
  State<CSearch> createState() => _CSearchState();
}

class _CSearchState extends State<CSearch> {
  final TextEditingController _controller = TextEditingController();
  final AppSearchController _searchController =
      Get.put(AppSearchController());

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _searchController.search(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(Assets.imagesArrowBackRounded, height: 32),
              ),
            ),
          ],
        ),
        title: SimpleTextField(hintText: 'Search...', controller: _controller),
        actions: [SizedBox(width: 20)],
      ),
      body: ListView.separated(
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        separatorBuilder: (_, __) => Container(
          height: 1,
          color: kBorderColor,
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        itemBuilder: (context, index) {
          return Obx(
            () {
              if (_searchController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_searchController.restaurants.isEmpty &&
                  _searchController.products.isEmpty) {
                return MyText(
                  text: 'No results yet.',
                  color: kQuaternaryColor,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_searchController.restaurants.isNotEmpty) ...[
                    MyText(
                      text: 'Restaurants',
                      size: 12,
                      weight: FontWeight.w600,
                      color: kQuaternaryColor,
                      paddingBottom: 8,
                    ),
                    ..._searchController.restaurants.map(
                      (restaurant) => GestureDetector(
                        onTap: () => Get.to(
                          () => CRestaurantDetails(
                            restaurantId: restaurant.id,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: MyText(
                            text: restaurant.name,
                            size: 14,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_searchController.products.isNotEmpty) ...[
                    SizedBox(height: 12),
                    MyText(
                      text: 'Products',
                      size: 12,
                      weight: FontWeight.w600,
                      color: kQuaternaryColor,
                      paddingBottom: 8,
                    ),
                    ..._searchController.products.map(
                      (product) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyText(
                          text:
                              '${product.name}  EUR ${product.price.toStringAsFixed(2)}',
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          );
        },
      ),
    );
  }
}
