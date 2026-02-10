import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/controllers/checkout_controller.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_order_confirmed.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_select_address.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

class CCheckout extends StatefulWidget {
  const CCheckout({super.key});

  @override
  State<CCheckout> createState() => _CCheckoutState();
}

class _CCheckoutState extends State<CCheckout> {
  int _selectedIndex = 0;
  final CheckoutController _controller = Get.put(CheckoutController());
  final TextEditingController _promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Checkout'),
      body: Column(
        children: [
          Container(
            margin: AppSizes.HORIZONTAL,
            height: 44,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kFillColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: List.generate(2, (index) {
                final isSelected = _selectedIndex == index;
                final labels = ['Delivery', 'Pickup'];
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
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppSizes.DEFAULT,
              physics: BouncingScrollPhysics(),
              children: [
                if (_selectedIndex == 0)
                  Obx(
                    () {
                      final address = _controller.addresses.isEmpty
                          ? null
                          : _controller.addresses.firstWhere(
                              (a) =>
                                  a.id ==
                                  _controller.selectedAddressId.value,
                              orElse: () => _controller.addresses.first,
                            );
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                        decoration: BoxDecoration(
                          color: kFillColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: address?.label ?? 'Select Address',
                                    size: 16,
                                    weight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 6),
                                  MyText(
                                    text: address?.displayLine ?? '',
                                    size: 12,
                                    color: kQuaternaryColor,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => CSelectAddress())?.then((_) {
                                  _controller.loadCheckoutData();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: kSecondaryColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: MyText(
                                  text: 'Change',
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: kSecondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                else ...[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      color: kFillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Select Date',
                                size: 16,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                text: 'October 20, 2000',
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(Assets.imagesCalendar, height: 20),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      color: kFillColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Select Time',
                                size: 16,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                text: '10:00 AM',
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(Assets.imagesTimer, height: 20),
                      ],
                    ),
                  ),
                ],
                MyText(
                  text: 'ADDED ITEMS',
                  size: 12,
                  letterSpacing: 1.0,
                  weight: FontWeight.w500,
                  color: kQuaternaryColor,
                  paddingTop: 18,
                  paddingBottom: 12,
                ),
                Obx(
                  () {
                    final cart = _controller.cart.value;
                    if (cart == null || cart.items.isEmpty) {
                      return MyText(
                        text: 'No items in cart.',
                        color: kQuaternaryColor,
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      physics: BouncingScrollPhysics(),
                      padding: AppSizes.ZERO,
                      itemCount: cart.items.length,
                      shrinkWrap: true,
                      itemBuilder: (context, sectionIndex) {
                        final item = cart.items[sectionIndex];
                        return _CartItem(
                          name: item.product?.name ?? 'Item',
                          imageUrl: item.product?.imageUrl ?? '',
                          price: item.itemTotal,
                          optionsText: item.selectedExtras.isNotEmpty
                              ? 'Add-on: ${item.selectedExtras.map((e) => e is Map ? e['name'] : e.toString()).join(', ')}'
                              : 'No add-ons',
                        );
                      },
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        paddingLeft: 12,
                        paddingRight: 12,
                        text: 'Tip your Driver',
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                      MyText(
                        paddingLeft: 12,
                        paddingRight: 12,
                        text:
                            'A small gesture makes a big difference. 100% of your tip goes to your driver.',
                        size: 12,
                        color: kQuaternaryColor,
                        paddingTop: 6,
                        lineHeight: 1.4,
                      ),
                      SizedBox(height: 14),
                      SizedBox(
                        height: 32,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          physics: BouncingScrollPhysics(),
                          itemCount: 5,
                          separatorBuilder: (context, index) => SizedBox(width: 4),
                          itemBuilder: (context, index) {
                            final amounts = [5, 10, 15, 20, 50];
                            final amount = amounts[index];
                            final isSelected = _controller.tipAmount.value == amount;
                            return GestureDetector(
                              onTap: () => _controller.setTip(amount.toDouble()),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? kSecondaryColor.withValues(alpha: 0.12)
                                      : kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: MyText(
                                    text: 'EUR $amount',
                                    size: 14,
                                    color: isSelected
                                        ? kSecondaryColor
                                        : kQuaternaryColor,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          style: TextStyle(
                            color: kTertiaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            hintText: 'Discount code',
                            hintStyle: TextStyle(
                              color: kTertiaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            filled: true,
                            fillColor: Color(0xffF4F4F4),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          controller: _promoController,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => _controller.applyPromo(
                        _promoController.text.trim(),
                      ),
                      child: Container(
                        width: 96,
                        height: 44,
                        decoration: BoxDecoration(
                          color: kSecondaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: MyText(
                            text: 'Apply',
                            size: 16,
                            weight: FontWeight.w500,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Obx(
                  () {
                    final totals = _controller.totals;
                    final details = [
                      {
                        'title': 'Items Price',
                        'value': (totals['itemsPrice'] ?? 0).toString(),
                        'currency': true,
                      },
                      {
                        'title': 'Discount',
                        'value': (totals['discount'] ?? 0).toString(),
                        'currency': true,
                      },
                      {
                        'title': 'Driver Tip',
                        'value': _controller.tipAmount.value.toStringAsFixed(2),
                        'currency': true,
                      },
                      {
                        'title': 'Subtotal',
                        'value': (totals['subtotal'] ?? 0).toString(),
                        'currency': true,
                      },
                      {
                        'title': 'Total Price',
                        'value': (totals['total'] ?? 0).toString(),
                        'currency': true,
                      },
                    ];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: details.map((detail) {
                        final String title = detail['title'] as String;
                        final Widget valueWidget = (detail['currency'] as bool)
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyText(text: 'EUR', weight: FontWeight.w700),
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
                            if (title == 'Subtotal')
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Image.asset(Assets.imagesDottedBorder),
                              ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 20),
                MyButton(
                  buttonText: 'Continue to payment',
                  onTap: () {
                    Get.bottomSheet(
                      _SelectPaymentMethod(
                        onConfirm: (method) async {
                          final type = _selectedIndex == 0 ? 'delivery' : 'pickup';
                          final order = await _controller.createOrder(
                            type: type,
                            paymentMethod: method,
                          );
                          if (order != null) {
                            Get.back();
                            Get.bottomSheet(
                              COrderConfirmed(order: order),
                              isScrollControlled: true,
                            );
                          } else if (_controller.errorMessage.value.isNotEmpty) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_controller.errorMessage.value),
                              ),
                            );
                          }
                        },
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnterCardInfo extends StatelessWidget {
  const _EnterCardInfo({required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      height: Get.height * 0.6,
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
          MyText(
            text: 'Enter Card Information',
            size: 20,
            weight: FontWeight.w500,
            paddingTop: 16,
          ),
          MyText(
            paddingTop: 8,
            text:
                'Please enter the card information mentioned on your debit or credit card.',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            size: 14,
            weight: FontWeight.w500,
            paddingBottom: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SimpleTextField(
                labelText: 'Card Number',
                hintText: '**** - **** - **** - *',
                radius: 12,
              ),
              SizedBox(height: 16),
              SimpleTextField(
                labelText: 'Card Holder Name',
                hintText: 'e.g. kevin backer',
                radius: 12,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SimpleTextField(
                      labelText: 'Expiry Date',
                      hintText: 'MM/YYYY',
                      radius: 12,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: SimpleTextField(
                      labelText: 'CVV',
                      hintText: 'e.g. 123',
                      radius: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          MyButton(
            buttonText: 'Confirm',
            onTap: onConfirm,
          ),
        ],
      ),
    );
  }
}

class _SelectPaymentMethod extends StatefulWidget {
  const _SelectPaymentMethod({required this.onConfirm});

  final void Function(String method) onConfirm;

  @override
  State<_SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<_SelectPaymentMethod> {
  int _selectedPaymentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'title': 'Debit/Credit Card', 'image': Assets.imagesCard},
      {'title': 'Apple Pay', 'image': Assets.imagesApplePay},
      {'title': 'Google Pay', 'image': Assets.imagesGPay},
      {'title': 'American Express', 'image': Assets.imagesAmericanExpress},
    ];

    return CustomDialog(
      height: Get.height * 0.52,
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
          MyText(
            text: 'Select Payment',
            size: 20,
            weight: FontWeight.w500,
            paddingTop: 16,
          ),
          MyText(
            paddingTop: 8,
            text: 'Please select the preferred payment method.',
            color: kQuaternaryColor,
            lineHeight: 1.5,
            size: 14,
            weight: FontWeight.w500,
            paddingBottom: 16,
          ),
          GridView.builder(
            padding: AppSizes.ZERO,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              mainAxisExtent: 80,
              crossAxisSpacing: 4,
            ),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              final item = categories[index];
              final selected = index == _selectedPaymentIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPaymentIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selected
                        ? kSecondaryColor.withValues(alpha: 0.12)
                        : kFillColor,
                    border: Border.all(
                      width: 1.0,
                      color: selected ? kSecondaryColor : kFillColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(item['image']!, height: 20),
                          if (selected)
                            Image.asset(Assets.imagesCheck, height: 18),
                        ],
                      ),
                      MyText(
                        text: item['title']!,
                        size: 12,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          MyButton(
            buttonText: 'Continue',
            onTap: () {
              if (_selectedPaymentIndex == 0) {
                Get.back();
                Get.bottomSheet(
                  _EnterCardInfo(
                    onConfirm: () {
                      Get.back();
                      widget.onConfirm('stripe');
                    },
                  ),
                  isScrollControlled: true,
                );
              } else {
                Get.back();
                widget.onConfirm('paypal');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.optionsText,
  });

  final String name;
  final String imageUrl;
  final double price;
  final String optionsText;

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
          MyText(
            text: 'EUR ${price.toStringAsFixed(2)}',
            size: 14,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
