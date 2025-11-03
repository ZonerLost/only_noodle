import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_select_address.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class CCart extends StatefulWidget {
  const CCart({super.key});

  @override
  State<CCart> createState() => _CCartState();
}

class _CCartState extends State<CCart> {
  bool _showEmpty = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showEmpty = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Shopping Cart"),
      body: _showEmpty
          ? _EmptyState()
          : ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              physics: BouncingScrollPhysics(),
              padding: AppSizes.HORIZONTAL,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, sectionIndex) {
                return _CartItem();
              },
            ),
      bottomNavigationBar: _showEmpty
          ? null
          : Container(
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
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: kGreenColor.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Assets.imagesGift, height: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: MyText(
                            text: 'add €100.00 more to receive a free gift',
                            size: 11,
                            weight: FontWeight.w600,
                            color: kGreenColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: kGreenColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: MyText(
                            text: 'Add items',
                            size: 11,
                            weight: FontWeight.w600,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(3, (index) {
                    final List<Map<String, dynamic>> details = [
                      {'title': 'Items', 'value': '3', 'currency': false},
                      {
                        'title': 'Items Price',
                        'value': '100.00',
                        'currency': true,
                      },
                      {
                        'title': 'Subtotal',
                        'value': '100.00',
                        'currency': true,
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
                            weight: FontWeight.w500,
                          );

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  text: title,
                                  color: kQuaternaryColor,
                                ),
                              ),
                              valueWidget,
                            ],
                          ),
                        ),
                        if (title == 'Items Price')
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Image.asset(Assets.imagesDottedBorder),
                          ),
                      ],
                    );
                  }),
                  SizedBox(height: 20),
                  MyButton(
                    buttonText: 'Continue to Checkout',
                    onTap: () {
                      Get.to(() => CSelectAddress());
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class _CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.22,
        motion: ScrollMotion(),
        children: [
          Expanded(
            child: Container(
              width: Get.width,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: kFillColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Image.asset(Assets.imagesTrash, height: 24)),
            ),
          ),
        ],
      ),
      child: Container(
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
                  MyText(
                    text: 'Chicken Cheese Strips',
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  MyText(
                    text: 'Add-on : Extra Cheese',
                    size: 12,
                    weight: FontWeight.w500,
                    color: kQuaternaryColor,
                  ),
                ],
              ),
            ),
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(text: '\$199.00', size: 14, weight: FontWeight.w500),
                Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Assets.imagesRemove, height: 20),
                    MyText(text: '1', size: 16, weight: FontWeight.w500),
                    Image.asset(Assets.imagesAdd, height: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(Assets.imagesNoItem, height: 72),
        MyText(
          text: 'No items added yet',
          paddingTop: 16,
          weight: FontWeight.w500,
          size: 18,
          textAlign: TextAlign.center,
        ),
        MyText(
          text: 'Explore your fav restaurants and order now!',
          paddingTop: 6,
          lineHeight: 1.5,
          weight: FontWeight.w500,
          size: 14,
          color: kQuaternaryColor,
          textAlign: TextAlign.center,
          paddingBottom: 20,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
