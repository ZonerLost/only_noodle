import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/auth/forgot_password/reset_password.dart';
import 'package:only_noodle/view/widget/custom_dialog_widget.dart';
import 'package:only_noodle/view/widget/heading_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(haveLeading: false),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.HORIZONTAL,
        physics: BouncingScrollPhysics(),
        children: [
          AuthHeading(
            marginTop: 0,
            title: 'Forgot Password',
            subTitle:
                "Please enter the email address that start’s with k*********@gmail.com",
          ),
          Container(
            height: 44,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: kFillColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: List.generate(2, (index) {
                final isSelected = _selectedIndex == index;
                final label = index == 0 ? 'Email address' : 'Phone';
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
          SizedBox(height: 16),
          if (_selectedIndex == 0)
            MyTextField(
              labelText: 'Email address',
              hintText: 'Enter your email',
              suffix: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(Assets.imagesEmail, height: 20)],
              ),
            )
          else
            MyTextField(
              labelText: 'Phone number',
              hintText: 'Enter your phone number',
              suffix: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(Assets.imagesPhone, height: 20)],
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              buttonText: 'Send Verification Link',
              onTap: () {
                Get.bottomSheet(
                  CustomDialog(
                    image: Assets.imagesMailSent,
                    title: 'Mail Sent !',
                    subTitle:
                        'We have sent a mail on your given email address. Please verify and reset your password.',
                    buttonText: 'Check Email',
                    onTap: () {
                      Get.back();
                      Get.to(() => ResetPassword());
                    },
                  ),
                  isScrollControlled: true,
                );
              },
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                MyText(
                  text: "Back to",
                  size: 16,
                  weight: FontWeight.w500,
                  color: kQuaternaryColor,
                ),
                MyText(
                  onTap: () {
                    Get.back();
                  },
                  text: ' Login',
                  size: 16,
                  color: kSecondaryColor,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
