import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/driver/d_home/d_order_details.dart';
import 'package:only_noodle/view/screens/driver/d_profile/d_profile.dart';
import 'package:only_noodle/view/screens/notifications/d_notifications.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/controllers/driver_home_controller.dart';

class DHome extends StatelessWidget {
  const DHome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DriverHomeController());
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 120,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              titleSpacing: 20.0,
              leadingWidth: 62,
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => DProfile());
                    },
                    child: CommonImageView(
                      height: 40,
                      width: 40,
                      radius: 100,
                      url: dummyImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: 'Welcome Back!',
                      color: kQuaternaryColor,
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(
                      () => MyText(
                        paddingTop: 2,
                        text: controller.profile.value?.name ?? 'Driver',
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Center(
                  child: GestureDetector(
                    onTap: () => Get.to(() => DNotifications()),
                    child: Image.asset(Assets.imagesNotification, height: 32),
                  ),
                ),
                SizedBox(width: 20),
              ],
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
                          hintText: 'Search orders...',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: _DOrders(controller: controller),
      ),
    );
  }
}

class _DOrders extends StatelessWidget {
  const _DOrders({required this.controller});

  final DriverHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.orders.isEmpty) {
            return Center(
              child: MyText(
                text: 'No orders available.',
                color: kQuaternaryColor,
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            physics: BouncingScrollPhysics(),
            padding: AppSizes.DEFAULT,
            itemCount: controller.orders.length,
            shrinkWrap: true,
            itemBuilder: (context, idx) {
              final order = controller.orders[idx];
              final date = order.createdAt ?? DateTime.now();
              final dateText =
                  '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}   |  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
              return GestureDetector(
                onTap: () {
                  Get.to(() => DOrderDetails(orderId: order.id));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: kFillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
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
                                      text: dateText,
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
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Customer name',
                                      size: 12,
                                      color: kQuaternaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 2),
                                    MyText(
                                      text: order.address?.label ?? 'Customer',
                                      size: 14,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 6,
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
                      Positioned(
                        top: 10,
                        left: -19,
                        bottom: 10,
                        child: Container(
                          width: 3,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
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
    );
  }
}
