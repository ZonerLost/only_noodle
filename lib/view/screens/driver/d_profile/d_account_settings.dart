import 'package:only_noodle/view/screens/profile/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/profile/change_password.dart';
import 'package:only_noodle/view/screens/profile/help_and_support.dart';
import 'package:only_noodle/view/screens/profile/privacy_policy.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';

class DAccountSettings extends StatefulWidget {
  const DAccountSettings({super.key});

  @override
  State<DAccountSettings> createState() => _DAccountSettingsState();
}

class _DAccountSettingsState extends State<DAccountSettings> {
  final controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Account Settings'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          ListView.separated(
            itemCount: 2,
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
                {
                  'icon': Assets.imagesEnableNotifications,
                  'title': 'Enable Notifications',
                },
              ];
              final detail = details[index];
              return _ProfileTile(
                icon: detail['icon'] ?? '',
                title: detail['title'] ?? '',
                trailing: index == 1
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
                      break;
                  }
                },
                showArrow: index == 0,
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
            itemCount: 3,
            shrinkWrap: true,
            padding: AppSizes.ZERO,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 8);
            },
            itemBuilder: (BuildContext context, int index) {
              final details = [
                {'icon': Assets.imagesHelpSupport, 'title': 'Help & Support'},
                {'icon': Assets.imagesPrivacy, 'title': 'Privacy Policy'},
                {'icon': Assets.imagesTerms, 'title': 'Terms & Conditions'},
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
                  }
                },
                showArrow: true,
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
            else
              Image.asset(Assets.imagesArrowNext, height: 20),
          ],
        ),
      ),
    );
  }
}
