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
import 'package:only_noodle/controllers/cart_controller.dart';

class CCart extends StatefulWidget {
  const CCart({super.key});

  @override
  State<CCart> createState() => _CCartState();
}

class _CCartState extends State<CCart> {
  final CartController _controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Shopping Cart"),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          final cart = _controller.cart.value;
          if (cart == null || cart.items.isEmpty) {
            return _EmptyState();
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            physics: BouncingScrollPhysics(),
            padding: AppSizes.HORIZONTAL,
            itemCount: cart.items.length,
            shrinkWrap: true,
            itemBuilder: (context, sectionIndex) {
              final item = cart.items[sectionIndex];
              return _CartItem(
                itemId: item.id,
                name: item.product?.name ?? 'Item',
                imageUrl: item.product?.imageUrl ?? '',
                optionsText: item.selectedExtras.isNotEmpty
                    ? 'Add-on: ${item.selectedExtras.map((e) => e is Map ? e['name'] : e.toString()).join(', ')}'
                    : 'No add-ons',
                price: item.itemTotal,
                quantity: item.quantity,
                onIncrease: () => _controller.increaseItem(
                  item.id,
                  item.quantity,
                ),
                onDecrease: () => _controller.decreaseItem(
                  item.id,
                  item.quantity,
                ),
                onRemove: () => _controller.removeItem(item.id),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          final cart = _controller.cart.value;
          if (cart == null || cart.items.isEmpty) {
            return SizedBox.shrink();
          }
          return Container(
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
                      {
                        'title': 'Items',
                        'value': cart.items
                            .fold<int>(0, (sum, item) => sum + item.quantity)
                            .toString(),
                        'currency': false,
                      },
                      {
                        'title': 'Items Price',
                        'value': cart.subtotal.toStringAsFixed(2),
                        'currency': true,
                      },
                      {
                        'title': 'Subtotal',
                        'value': (cart.subtotal - cart.discount)
                            .toStringAsFixed(2),
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
            );
        },
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.itemId,
    required this.name,
    required this.optionsText,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.imageUrl,
  });

  final String itemId;
  final String name;
  final String optionsText;
  final double price;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final String imageUrl;

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
              child: GestureDetector(
                onTap: onRemove,
                child: Center(
                  child: Image.asset(Assets.imagesTrash, height: 24),
                ),
              ),
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
            CommonImageView(
              height: 45,
              width: 45,
              radius: 8,
              url: imageUrl.isNotEmpty ? imageUrl : dummyImg,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: name,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  MyText(
                    text: optionsText,
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
                MyText(
                  text: 'EUR ${price.toStringAsFixed(2)}',
                  size: 14,
                  weight: FontWeight.w500,
                ),
                Row(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onDecrease,
                      child: Image.asset(Assets.imagesRemove, height: 20),
                    ),
                    MyText(
                      text: quantity.toString(),
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: onIncrease,
                      child: Image.asset(Assets.imagesAdd, height: 20),
                    ),
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
