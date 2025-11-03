import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';
import 'package:only_noodle/view/screens/auth/register/customer_complete_profile.dart';
import 'package:only_noodle/view/screens/auth/register/driver_complete_profile.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/heading_widget.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 54,
      height: 60,
      textStyle: TextStyle(
        fontSize: 30,
        color: kTertiaryColor,
        fontWeight: FontWeight.w500,
      ),
      decoration: BoxDecoration(
        color: kFillColor,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: kInputBorderColor, width: 1.0),
        ),
      ),
    );
    return Scaffold(
      appBar: simpleAppBar(haveLeading: false),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.HORIZONTAL,
        physics: BouncingScrollPhysics(),
        children: [
          AuthHeading(
            marginTop: 0,
            title: 'Verification Code',
            subTitle:
                'We have sent a verification code on your email address chri******@gmail.com',
          ),
          Pinput(
            length: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: kSecondaryColor.withValues(alpha: 0.1),
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: TextStyle(
                fontSize: 30,
                color: kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: kSecondaryColor.withValues(alpha: 0.1),
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: TextStyle(
                fontSize: 30,
                color: kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => print(pin),
          ),
          SizedBox(height: 50),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MyText(
                text: "Didn't receive code?",
                size: 16,
                weight: FontWeight.w500,
                color: kQuaternaryColor,
              ),
              MyText(
                text: " 00:54",
                size: 16,
                weight: FontWeight.w500,
                color: kSecondaryColor,
              ),
            ],
          ),
          SizedBox(height: 20),
          MyButton(
            buttonText: 'Continue',
            onTap: () {
              Get.bottomSheet(
                CustomDialog(
                  image: Assets.imagesMailSent,
                  title: 'Account Created',
                  subTitle:
                      'You have successfully created your account. You are only one step away from exploring the app.',
                  buttonText: 'Done',
                  onTap: () {
                    Get.back();
                    final auth = Get.find<AuthController>();
                    if (auth.selectedRole == UserRole.driver) {
                      Get.to(() => DriverCompleteProfile());
                    } else {
                      Get.to(() => CustomerCompleteProfile());
                    }
                  },
                ),
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
