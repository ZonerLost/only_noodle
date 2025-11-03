import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class DNotifications extends StatefulWidget {
  const DNotifications({super.key});

  @override
  State<DNotifications> createState() => _DNotificationsState();
}

class _DNotificationsState extends State<DNotifications> {
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

  final List<Map<String, dynamic>> _notifications = [
    {
      'date': 'Today',
      'items': [
        {
          'title': 'Account Created!',
          'subTitle': 'Your account has been created.',
          'time': '12:33 am',
          'unread': true,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Completed',
          'subTitle': 'Order has been completed!',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': true,
        },
      ],
    },

    {
      'date': 'Yesterday',
      'items': [
        {
          'title': 'Account Created!',
          'subTitle': 'Your account has been created.',
          'time': '12:33 am',
          'unread': true,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': false,
        },
      ],
    },

    {
      'date': 'Other',
      'items': [
        {
          'title': 'Account Created!',
          'subTitle': 'Your account has been created.',
          'time': '12:33 am',
          'unread': true,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Completed',
          'subTitle': 'Order has been completed!',
          'time': '12:33 am',
          'unread': false,
        },
        {
          'title': 'Order Assigned',
          'subTitle': 'New order has been assigned. View',
          'time': '12:33 am',
          'unread': true,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Notifications"),
      body: _showEmpty
          ? _EmptyState()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: AppSizes.HORIZONTAL,
              itemCount: _notifications.length,
              shrinkWrap: true,
              itemBuilder: (context, sectionIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyText(
                      text: (_notifications[sectionIndex]['date'] as String)
                          .toUpperCase(),
                      size: 12,
                      letterSpacing: 1.0,
                      weight: FontWeight.w500,
                      color: kQuaternaryColor,
                      paddingTop: 16,
                      paddingBottom: 8,
                    ),
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: AppSizes.ZERO,
                      itemCount: (_notifications[sectionIndex]['items'] as List)
                          .length,
                      itemBuilder: (ctx, itemIndex) {
                        final item =
                            (_notifications[sectionIndex]['items']
                                    as List)[itemIndex]
                                as Map<String, dynamic>;
                        return _NotificationTile(
                          title: item['title'] as String,
                          subTitle: item['subTitle'] as String,
                          time: item['time'] as String,
                          unread: item['unread'] as bool? ?? false,
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
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

class _NotificationTile extends StatelessWidget {
  final String title, subTitle, time;
  final bool unread;
  const _NotificationTile({
    required this.title,
    required this.time,
    required this.subTitle,
    required this.unread,
  });

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
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kFillColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: kSecondaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: MyText(
                text: title.isNotEmpty ? title.characters.first : '-',
                size: 16,
                weight: FontWeight.bold,
                color: kSecondaryColor,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: MyText(
                          text: title,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                      MyText(
                        text: time,
                        size: 12,
                        weight: FontWeight.w500,
                        color: kQuaternaryColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              // detect either 'Tap to view' or 'View' and render the link portion styled
                              final linkKey = subTitle.contains('Tap to view')
                                  ? 'Tap to view'
                                  : (subTitle.contains('View') ? 'View' : '');
                              if (linkKey.isEmpty) {
                                return MyText(
                                  paddingTop: 0,
                                  text: subTitle,
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: kQuaternaryColor,
                                );
                              }

                              final parts = subTitle.split(linkKey);
                              final before = parts.isNotEmpty
                                  ? parts.first
                                  : '';
                              final after = parts.length > 1
                                  ? parts.sublist(1).join(linkKey)
                                  : '';

                              return RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.3,
                                    fontFamily: AppFonts.Manrope,
                                    fontWeight: FontWeight.w500,
                                    color: kQuaternaryColor,
                                  ),
                                  children: [
                                    if (before.isNotEmpty)
                                      TextSpan(text: before),
                                    TextSpan(
                                      text:
                                          linkKey, // show as link (either 'Tap to view' or 'View')
                                      style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    if (after.isNotEmpty) TextSpan(text: after),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (unread)
                          Icon(Icons.circle, size: 8, color: kSecondaryColor),
                      ],
                    ),
                  ),
                ],
              ),
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
        Image.asset(Assets.imagesNoNotification, height: 72),
        MyText(
          text: 'No Notifications Yet!',
          paddingTop: 16,
          weight: FontWeight.w500,
          size: 18,
          textAlign: TextAlign.center,
        ),
        MyText(
          text: 'No Notifications to be shown yet.',
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
