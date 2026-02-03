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
import 'package:only_noodle/controllers/driver_order_controller.dart';

class DOrderDetails extends StatefulWidget {
  const DOrderDetails({super.key, required this.orderId});

  final String orderId;

  @override
  State<DOrderDetails> createState() => _DOrderDetailsState();
}

class _DOrderDetailsState extends State<DOrderDetails> {
  late final DriverOrderController _controller;
  bool _orderPicked = false;
  bool _markComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(DriverOrderController(widget.orderId), tag: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Order Details'),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          final order = _controller.order.value;
          if (order == null) {
            return Center(
              child: MyText(text: 'Order not found', color: kQuaternaryColor),
            );
          }
          return ListView(
            shrinkWrap: true,
            padding: AppSizes.DEFAULT,
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kFillColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Image.asset(Assets.imagesLocation, height: 40),
                        Expanded(
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: order.address?.displayLine ?? '',
                                size: 13,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        MyText(
                          text: 'N/A',
                          size: 14,
                          color: kQuaternaryColor,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withValues(alpha: 0.12),
                        border: Border(
                          left: BorderSide(color: kSecondaryColor, width: 2),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: MyText(
                        text: 'Google Maps',
                        size: 12,
                        color: kSecondaryColor,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kFillColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1.0, color: kFillColor),
                            ),
                            child: CommonImageView(
                              height: 30,
                              width: 30,
                              radius: 100.0,
                              url: dummyImg,
                            ),
                          ),
                          Expanded(
                            child: MyText(
                              paddingLeft: 8,
                              text: order.address?.label ?? 'Customer',
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(Assets.imagesCall, height: 32),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: kBorderColor,
                    ),
                    MyText(
                      text: 'Order Items',
                      size: 12,
                      weight: FontWeight.w500,
                      color: kQuaternaryColor,
                    ),
                    ...order.items.map<Widget>((item) {
                      final map = item is Map<String, dynamic> ? item : {};
                      final name = (map['name'] ?? 'Item').toString();
                      final qty = (map['quantity'] ?? 1).toString();
                      final price = (map['price'] ?? map['total'] ?? 0).toString();
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            MyText(text: '${qty}x', weight: FontWeight.w600),
                            Expanded(
                              child: MyText(
                                paddingLeft: 10,
                                text: name,
                                color: kQuaternaryColor,
                              ),
                            ),
                            MyText(text: 'EUR', weight: FontWeight.w700),
                            MyText(text: price, weight: FontWeight.w500),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
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
            ...List.generate(3, (index) {
              final order = _controller.order.value;
              final List<Map<String, dynamic>> details = [
                {
                  'title': 'Items Price',
                  'value': order?.subtotal.toStringAsFixed(2) ?? '0.00',
                  'currency': true,
                },
                {
                  'title': 'Total Price',
                  'value': order?.total.toStringAsFixed(2) ?? '0.00',
                  'currency': true,
                },
                {
                  'title': 'Payment Type',
                  'value': order?.paymentMethod ?? 'Cash on Delivery',
                  'currency': false,
                },
              ];

              final detail = details[index];
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
                      weight: FontWeight.w700,
                    );

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyText(text: title, color: kQuaternaryColor),
                        ),
                        valueWidget,
                      ],
                    ),
                  ),
                  if (index < details.length - 1)
                    index == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Image.asset(Assets.imagesDottedBorder),
                          )
                        : Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(vertical: 6),
                            color: kBorderColor,
                          ),
                ],
              );
            }),
            SizedBox(height: 20),
            MyButton(
              buttonText: _markComplete
                  ? 'Mark as Completed'
                  : (_orderPicked ? 'Order Picked' : 'Start Order'),
              onTap: () async {
                if (_markComplete) {
                  Get.bottomSheet(
                    CustomDialog(
                      height: Get.height * 0.57,
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
                              return Center(
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
                                    return Image.asset(Assets.imagesStar, height: 36);
                                  },
                                  itemPadding: EdgeInsets.symmetric(horizontal: 5),
                                  onRatingUpdate: (rating) => ratingNotifier.value = rating,
                                ),
                              );
                            },
                          ),
                          MyText(
                            text: 'Submit Feedback',
                            size: 24,
                            weight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            paddingTop: 12,
                          ),
                          MyText(
                            paddingTop: 8,
                            text:
                                'How was your experience with this order. Feel free to share the feedback regarding the customer behavior.',
                            color: kQuaternaryColor,
                            textAlign: TextAlign.center,
                            lineHeight: 1.5,
                            size: 16,
                            weight: FontWeight.w500,
                            paddingBottom: 16,
                          ),
                          SimpleTextField(
                            hintText: 'Your Feedback',
                            maxLines: 4,
                          ),
                          SizedBox(height: 16),
                          MyButton(buttonText: 'Submit', onTap: () {}),
                        ],
                      ),
                    ),
                    isScrollControlled: true,
                  );
                } else {
                  Get.bottomSheet(
                    CustomDialog(
                      image: Assets.imagesOrderStarted,
                      title: _orderPicked ? 'Order Picked' : 'Start Order',
                      subTitle:
                          _orderPicked
                              ? "You have picked up the food from the restaurant. Please deliver it to the given customer address. Don't forget to collect the payment."
                              : 'You have started the order. Please pick up the food from the restaurant and deliver it to the customer\'s address within the time period.',
                      actionButtons: MyButton(
                        buttonText: 'Done',
                        onTap: () async {
                          Get.back();
                          if (!_orderPicked) {
                            await _controller.acceptOrder();
                            setState(() {
                              _orderPicked = true;
                              _markComplete = false;
                            });
                          } else {
                            await _controller.updateStatus('delivered');
                            setState(() {
                              _orderPicked = false;
                              _markComplete = true;
                            });
                          }
                        },
                      ),
                    ),
                    isScrollControlled: true,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}