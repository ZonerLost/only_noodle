import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_order_confirmed.dart';
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
                                text: 'Home Address',
                                size: 16,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 6),
                              MyText(
                                text: 'St3, Wilson road, Brooklyn, USA 10121',
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                      ],
                    ),
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
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  physics: BouncingScrollPhysics(),
                  padding: AppSizes.ZERO,
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, sectionIndex) {
                    return _CartItem();
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
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 4),
                          itemBuilder: (context, index) {
                            final title = [
                              '\$5',
                              '\$10',
                              '\$15',
                              '\$20',
                              '\$50',
                            ];
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? kSecondaryColor.withValues(alpha: 0.12)
                                    : kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: MyText(
                                  text: title[index],
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
                    ],
                  ),
                ),
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
                              text: '3,454 pts',
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 6),
                            MyText(
                              text: 'Available loyalty points',
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MyText(
                          text: 'Redeem',
                          size: 14,
                          weight: FontWeight.w500,
                          color: kPrimaryColor,
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
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
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
                  ],
                ),
                SizedBox(height: 16),
                ...List.generate(5, (index) {
                  final List<Map<String, dynamic>> details = [
                    {
                      'title': 'Items Price',
                      'value': '199.00',
                      'currency': true,
                    },
                    {
                      'title': 'Discount (5%)',
                      'value': '15.00',
                      'currency': true,
                    },
                    {'title': 'Driver Tip', 'value': '10.00', 'currency': true},
                    {'title': 'Subtotal', 'value': '500.00', 'currency': true},
                    {
                      'title': 'Total Price',
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
                      if (title == 'Subtotal')
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Image.asset(Assets.imagesDottedBorder),
                        ),
                    ],
                  );
                }),
                SizedBox(height: 20),
                MyButton(
                  buttonText: 'Continue to payment',
                  onTap: () {
                    Get.bottomSheet(
                      _SelectPaymentMethod(),
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
  const _EnterCardInfo();

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
              Get.bottomSheet(_SelectPaymentMethod(), isScrollControlled: true);
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
            onTap: () {
              Get.back();
              Get.bottomSheet(COrderConfirmed(), isScrollControlled: true);
            },
          ),
        ],
      ),
    );
  }
}

class _SelectPaymentMethod extends StatefulWidget {
  const _SelectPaymentMethod();

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
              Get.back();
              if (_selectedPaymentIndex == 0) {
                Get.bottomSheet(_EnterCardInfo(), isScrollControlled: true);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
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
          MyText(text: '\$199.00', size: 14, weight: FontWeight.w500),
        ],
      ),
    );
  }
}
