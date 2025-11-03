import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

class DOrderHistory extends StatefulWidget {
  const DOrderHistory({super.key});

  @override
  State<DOrderHistory> createState() => _DOrderHistoryState();
}

class _DOrderHistoryState extends State<DOrderHistory> {
  late final List<Map<String, dynamic>> _orders;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _orders = [
      {
        'date': 'Today',
        'orders': [
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
        ],
      },
      {
        'date': 'Yesterday',
        'orders': [
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
        ],
      },
      {
        'date': 'Other',
        'orders': [
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
          {
            'id': 'SN-343',
            'customer': 'Chris T.',
            'price': '€ 50.00',
            'location': 'Wilson St, San Diego',
            'date': DateTime(now.year, now.month, now.day, 21, 32),
            'status': 'Delivered',
          },
        ],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Order History'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: AppSizes.DEFAULT,
        itemCount: _orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: _orders[index]['date'].toUpperCase(),
                size: 12,
                letterSpacing: 1.0,
                weight: FontWeight.w500,
                color: kQuaternaryColor,
                paddingTop: 4,
                paddingBottom: 8,
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: AppSizes.ZERO,
                shrinkWrap: true,
                itemCount: (_orders[index]['orders'] as List).length,
                itemBuilder: (context, idx) {
                  final order = (_orders[index]['orders'] as List)[idx];
                  final date = order['date'] as DateTime;
                  final dateText =
                      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}   |  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                  return GestureDetector(
                    onTap: () {},
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
                                      text: 'Order ID #${order['id']}',
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: kGreenColor.withValues(alpha: .12),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  spacing: 6,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: kGreenColor,
                                    ),
                                    MyText(
                                      text:
                                          order['status'] as String? ??
                                          'Delivered',
                                      size: 12,
                                      weight: FontWeight.w600,
                                      color: kGreenColor,
                                    ),
                                  ],
                                ),
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
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Customer name',
                                      size: 10,
                                      color: kQuaternaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 2),
                                    MyText(
                                      text: order['customer'] as String,
                                      size: 12,
                                      weight: FontWeight.w500,
                                    ),
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
                                    MyText(
                                      text: order['price'] as String,
                                      size: 12,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: 'Location',
                                      size: 10,
                                      color: kQuaternaryColor,
                                      weight: FontWeight.w500,
                                    ),
                                    SizedBox(height: 2),
                                    MyText(
                                      text: order['location'] as String,
                                      size: 12,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

