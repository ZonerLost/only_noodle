import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:only_noodle/controllers/notifications_controller.dart';

class DNotifications extends StatefulWidget {
  const DNotifications({super.key});

  @override
  State<DNotifications> createState() => _DNotificationsState();
}

class _DNotificationsState extends State<DNotifications> {
  final NotificationsController _controller =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Notifications"),
      body: Obx(
        () {
          if (_controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (_controller.notifications.isEmpty) {
            return _EmptyState();
          }
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: AppSizes.HORIZONTAL,
            itemCount: _controller.notifications.length,
            shrinkWrap: true,
            separatorBuilder: (ctx, index) {
              return Container(margin: EdgeInsets.symmetric(vertical: 4));
            },
            itemBuilder: (context, index) {
              final item = _controller.notifications[index];
              return _NotificationTile(
                title: item.title,
                subTitle: item.message,
                time: item.createdAt?.toIso8601String() ?? '',
                unread: !item.read,
                onDelete: () => _controller.delete(item.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title, subTitle, time;
  final bool unread;
  final VoidCallback? onDelete;
  const _NotificationTile({
    required this.title,
    required this.time,
    required this.subTitle,
    required this.unread,
    this.onDelete,
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
              child: GestureDetector(
                onTap: onDelete,
                child: Center(child: Image.asset(Assets.imagesTrash, height: 24)),
              ),
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
                          child: MyText(
                            paddingTop: 0,
                            text: subTitle,
                            size: 12,
                            weight: FontWeight.w500,
                            color: kQuaternaryColor,
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