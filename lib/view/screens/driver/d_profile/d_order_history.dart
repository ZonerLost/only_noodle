import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/controllers/driver_history_controller.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class DOrderHistory extends StatelessWidget {
  const DOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverHistoryController());
    return Scaffold(
      appBar: simpleAppBar(title: 'Order History'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.orders.isEmpty) {
            return Center(
              child: MyText(
                text: 'No orders found.',
                color: kQuaternaryColor,
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            padding: AppSizes.DEFAULT,
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return Container(
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
                        Image.asset(Assets.imagesOrderId, height: 40),
                        Expanded(
                          child: Column(
                            spacing: 4,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Order ID #${order.orderNumber}',
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                              MyText(
                                text: order.createdAt?.toIso8601String() ?? '',
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                        MyText(
                          text: 'EUR ${order.total.toStringAsFixed(2)}',
                          size: 16,
                          weight: FontWeight.w600,
                        ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Status',
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 2),
                              MyText(
                                text: order.status,
                                size: 14,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Location',
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(height: 2),
                              MyText(
                                text: order.address?.displayLine ?? '',
                                size: 14,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}