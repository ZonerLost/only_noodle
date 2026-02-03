import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_track_order.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/controllers/order_history_controller.dart';
import 'package:intl/intl.dart';

class COrderHistory extends StatefulWidget {
  const COrderHistory({super.key});

  @override
  State<COrderHistory> createState() => _COrderHistoryState();
}

class _COrderHistoryState extends State<COrderHistory> {
  int _selectedIndex = 0;
  final OrderHistoryController _controller =
      Get.put(OrderHistoryController());
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy - hh:mm a');
    return Scaffold(
      appBar: simpleAppBar(title: 'Order History', haveLeading: false),
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
              children: List.generate(3, (index) {
                final isSelected = _selectedIndex == index;
                final labels = ['Active', 'Completed', 'Cancelled'];
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
            child: Builder(
              builder: (context) {
                return Obx(
                  () {
                    if (_controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final filteredOrders = _controller.orders.where((o) {
                      final status = o.status.toLowerCase();
                      if (_selectedIndex == 0) {
                        return status == 'preparing' ||
                            status == 'confirmed' ||
                            status == 'pending';
                      }
                      if (_selectedIndex == 1) {
                        return status == 'completed' || status == 'delivered';
                      }
                      return status == 'cancelled';
                    }).toList();
                    if (filteredOrders.isEmpty) {
                      return Center(
                        child: MyText(
                          text: 'No orders found.',
                          color: kQuaternaryColor,
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: AppSizes.DEFAULT,
                      shrinkWrap: true,
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, idx) {
                        final order = filteredOrders[idx];
                        final dateText = order.createdAt == null
                            ? ''
                            : dateFormat.format(order.createdAt!);
                        return _OrderHistoryTile(
                          id: order.orderNumber.isNotEmpty
                              ? int.tryParse(order.orderNumber) ?? 0
                              : 0,
                          orderId: order.id,
                          customer: order.address?.label ?? 'Driver',
                          price: order.total.toStringAsFixed(2),
                          location: order.address?.displayLine ?? '',
                          status: order.status,
                          dateText: dateText,
                          onTap: () {},
                          isActive: _selectedIndex == 0 && idx == 0,
                          onReview: (rating, comment) {
                            _controller.submitReview(
                              orderId: order.id,
                              rating: rating,
                              comment: comment,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Private widget for a single order tile used in COrderHistory
class _OrderHistoryTile extends StatelessWidget {
  final int id;
  final String orderId;
  final String customer;
  final String price;
  final String location;
  final String status;
  final String dateText;
  final bool isActive;
  final VoidCallback? onTap;
  final void Function(double rating, String comment)? onReview;

  const _OrderHistoryTile({
    required this.id,
    required this.orderId,
    required this.customer,
    required this.price,
    required this.location,
    required this.status,
    required this.dateText,
    this.onTap,
    required this.isActive,
    this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kFillColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isActive)
              Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: kGreenColor.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: MyText(
                  text: 'Your order will be ready in approx. 23 minutes',
                  size: 12,
                  weight: FontWeight.w600,
                  color: kGreenColor,
                ),
              ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Order ID #$id',
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                      MyText(
                        text: dateText,
                        color: kQuaternaryColor,
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                (() {
                  final s = status.toLowerCase();
                  final Color statusColor = s == 'preparing'
                      ? kGreenColor
                      : s == 'completed'
                      ? kSecondaryColor
                      : Colors.red;
                  final Color statusBgColor = s == 'preparing'
                      ? kGreenColor.withValues(alpha: .12)
                      : s == 'completed'
                      ? kSecondaryColor.withValues(alpha: .12)
                      : Colors.red.withValues(alpha: .12);

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: MyText(
                      text: status,
                      size: 12,
                      weight: FontWeight.w600,
                      color: statusColor,
                    ),
                  );
                }()),
              ],
            ),
            Container(
              height: 1,
              color: kBorderColor,
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Driver name',
                        size: 10,
                        color: kQuaternaryColor,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 2),
                      MyText(text: customer, size: 12, weight: FontWeight.w500),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Price',
                        size: 10,
                        color: kQuaternaryColor,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 2),
                      MyText(text: price, size: 12, weight: FontWeight.w500),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Restaurant',
                        size: 10,
                        color: kQuaternaryColor,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 2),
                      MyText(text: location, size: 12, weight: FontWeight.w500),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            MyButton(
              height: 44,
              textSize: 14,
              buttonText: status.toLowerCase() == 'preparing'
                  ? 'Track Order'
                  : 'Write a review',
              onTap: status.toLowerCase() == 'preparing'
                  ? () {
                      Get.to(() => CTrackOrder(orderId: orderId));
                    }
                  : () {
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
                                    Image.asset(
                                      Assets.imagesArrowBack,
                                      height: 20,
                                    ),
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
                                  final ratingNotifier = ValueNotifier<double>(
                                    4.0,
                                  );
                                  final commentController =
                                      TextEditingController();
                                  return Column(
                                    children: [
                                      Center(
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
                                            return Image.asset(
                                              Assets.imagesStar,
                                              height: 36,
                                            );
                                          },
                                          itemPadding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          onRatingUpdate: (rating) =>
                                              ratingNotifier.value = rating,
                                        ),
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
                                        controller: commentController,
                                      ),
                                      SizedBox(height: 16),
                                      MyButton(
                                        buttonText: 'Submit',
                                        onTap: () {
                                          onReview?.call(
                                            ratingNotifier.value,
                                            commentController.text.trim(),
                                          );
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
              bgColor: kSecondaryColor.withValues(alpha: 0.12),
              textColor: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
