import 'package:only_noodle/view/screens/customer/c_profile/c_addresses.dart';
import 'package:only_noodle/view/screens/customer/c_profile/c_edit_profile.dart';
import 'package:only_noodle/view/screens/customer/c_profile/loyalty_rewards.dart';
import 'package:only_noodle/view/screens/profile/language.dart';
import 'package:only_noodle/view/screens/profile/terms_condition.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/screens/profile/change_password.dart';
import 'package:only_noodle/view/screens/profile/help_and_support.dart';
import 'package:only_noodle/view/screens/profile/privacy_policy.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:only_noodle/controllers/profile_controller.dart';
import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';
import 'package:only_noodle/view/screens/auth/login/login.dart';

class CProfile extends StatefulWidget {
  const CProfile({super.key});

  @override
  State<CProfile> createState() => _CProfileState();
}

class _CProfileState extends State<CProfile> {
  final controller = ValueNotifier<bool>(false);
  final ProfileController _profileController = Get.put(ProfileController());
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        title: 'User Profile',
        haveLeading: false,
        centerTitle: false,
      ),
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
                        Get.to(() => CEditProfile());
                      },
                      child: Image.asset(Assets.imagesEditRounded, height: 32),
                    ),
                  ],
                ),
                Obx(
                  () => MyText(
                    paddingTop: 16,
                    text: _profileController.profile.value?.name ?? 'Guest',
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
            itemCount: 5,
            shrinkWrap: true,
            padding: AppSizes.ZERO,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              final details = [
                {
                  'icon': Assets.imagesChangePassword,
                  'title': 'Change Password',
                },
                {'icon': Assets.imagesAddresses, 'title': 'My Addresses'},
                {'icon': Assets.imagesLoyalty, 'title': 'Loyalty rewards'},
                {
                  'icon': Assets.imagesEnableNotifications,
                  'title': 'Enable Notifications',
                },
                {'icon': Assets.imagesLanguage, 'title': 'Language'},
              ];
              final detail = details[index];
              return _ProfileTile(
                icon: detail['icon'] ?? '',
                title: detail['title'] ?? '',
                trailing: index == 3
                    ? AdvancedSwitch(
                        controller: controller,
                        activeColor: kSecondaryColor,
                        inactiveColor: kPrimaryColor,
                        activeChild: Image.asset(Assets.imagesOff, height: 8),
                        inactiveChild: Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Image.asset(Assets.imagesOn, height: 8),
                        ),
                        borderRadius: BorderRadius.circular(50),
                        width: 40.0,
                        height: 24.0,
                        enabled: true,
                        disabledOpacity: 0.5,
                        onChanged: (newValue) {
                          setState(() {
                            controller.value = newValue;
                          });
                        },
                      )
                    : null,
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => ChangePassword());
                      break;
                    case 1:
                      Get.to(() => CAddresses());
                      break;
                    case 2:
                      Get.to(() => LoyaltyRewards());
                      break;
                    case 3:
                      // Enable Notifications tap
                      break;
                    case 4:
                      Get.to(() => Languages());
                      break;
                  }
                },
                showArrow: index != 3,
              );
            },
          ),

          MyText(
            text: 'ABOUT',
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
              final List<Map<String, String>> details = [
                {'icon': Assets.imagesHelpSupport, 'title': 'Help & Support'},
                {'icon': Assets.imagesPrivacy, 'title': 'Privacy Policy'},
                {'icon': Assets.imagesTerms, 'title': 'Terms & Conditions'},
                {'icon': Assets.imagesLogout, 'title': 'Logout'},
              ];
              final detail = details[index];
              return _ProfileTile(
                icon: detail['icon'] ?? '',
                title: detail['title'] ?? '',
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => HelpAndSupport());
                      break;
                    case 1:
                      Get.to(() => PrivacyPolicy());
                      break;
                    case 2:
                      Get.to(() => TermsCondition());
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
    this.trailing,
    required this.showArrow,
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
