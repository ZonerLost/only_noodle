import 'package:only_noodle/view/screens/driver/d_profile/d_account_settings.dart';
import 'package:only_noodle/view/screens/driver/d_profile/d_order_history.dart';
import 'package:only_noodle/view/screens/profile/language.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/driver/d_profile/d_edit_profile.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:only_noodle/controllers/driver_profile_controller.dart';
import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';
import 'package:only_noodle/view/screens/auth/login/login.dart';

class DProfile extends StatefulWidget {
  const DProfile({super.key});

  @override
  State<DProfile> createState() => _DProfileState();
}

class _DProfileState extends State<DProfile> {
  final controller = ValueNotifier<bool>(false);
  final DriverProfileController _profileController =
      Get.put(DriverProfileController());
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _profileController.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'User Profile'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kFillColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 32, height: 32),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.0, color: kSecondaryColor),
                      ),
                      child: CommonImageView(
                        height: 60,
                        width: 60,
                        radius: 100.0,
                        url: dummyImg,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => DEditProfile());
                      },
                      child: Image.asset(Assets.imagesEditRounded, height: 32),
                    ),
                  ],
                ),
                Obx(
                  () => MyText(
                    paddingTop: 16,
                    text: _profileController.profile.value?.name ?? 'Driver',
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                ),
                Obx(
                  () => MyText(
                    paddingTop: 4,
                    text: _profileController.profile.value?.email ?? '',
                    size: 12,
                    color: kQuaternaryColor,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Obx(
            () => Row(
              spacing: 8,
              children: List.generate(2, (index) {
                final stats = [
                  {
                    'period': 'This Week',
                    'value':
                        (_profileController.stats['orders'] ?? 0).toString(),
                    'label': 'Orders Completed',
                  },
                  {
                    'period': 'This Week',
                    'value':
                        'EUR ${(_profileController.tipsSummary['total'] ?? 0).toString()}',
                    'label': 'Tips Collected',
                  },
                ];
                final item = stats[index];
                final period = item['period'] ?? '';
                final value = item['value'] ?? '';
                final subtitle = item['label'] ?? '';
                return Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: kFillColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                index == 0
                                    ? Assets.imagesOrderCompleted
                                    : Assets.imagesTipsCollected,
                                height: 44,
                              ),
                              MyText(
                                text: period,
                                size: 12,
                                color: kQuaternaryColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MyText(
                                  text: value,
                                  size: 18,
                                  weight: FontWeight.w600,
                                ),
                                SizedBox(height: 4),
                                MyText(
                                  text: subtitle,
                                  size: 12,
                                  color: kQuaternaryColor,
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          MyText(
            text: 'SETTINGS',
            size: 12,
            letterSpacing: 1.0,
            weight: FontWeight.w500,
            color: kQuaternaryColor,
            paddingTop: 18,
            paddingBottom: 12,
          ),
          ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            padding: AppSizes.ZERO,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              final details = [
                {'icon': Assets.imagesOrderHistory, 'title': 'Orders History'},
                {
                  'icon': Assets.imagesAccountSettings,
                  'title': 'Account Settings',
                },
                {'icon': Assets.imagesLanguage, 'title': 'Language'},
                {'icon': Assets.imagesLogout, 'title': 'Logout'},
              ];
              final detail = details[index];
              return _ProfileTile(
                icon: detail['icon'] ?? '',
                title: detail['title'] ?? '',
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => DOrderHistory());
                      break;
                    case 1:
                      Get.to(() => DAccountSettings());
                      break;
                    case 2:
                      Get.to(() => Languages());
                      break;
                    case 3:
                      Get.bottomSheet(
                        CustomDialog(
                          height: 380,
                          image: Assets.imagesLogoutImage,
                          title: 'Logout',
                          subTitle:
                              'Are you sure you want to logout from this app?',
                          buttonText: 'Yes, Logout',
                          onTap: () {
                            Get.back();
                            _authController.logout();
                            Get.offAll(() => Login());
                          },
                        ),
                        isScrollControlled: true,
                      );
                      break;
                  }
                },
                showArrow: index != 3,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.showArrow,
    this.trailing,
  });
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool showArrow;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kFillColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(icon, height: 38),
            Expanded(
              child: MyText(
                paddingLeft: 10,
                text: title,
                size: 16,
                weight: FontWeight.w500,
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showArrow)
              Image.asset(Assets.imagesArrowNext, height: 20),
          ],
        ),
      ),
    );
  }
}
