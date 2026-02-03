import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_fonts.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/auth/register/email_verification.dart';
import 'package:only_noodle/view/widget/custom_check_box_widget.dart';
import 'package:only_noodle/view/widget/heading_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _selectedRole = 0;
  AuthController _authController = Get.put(AuthController());
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  bool _agree = false;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
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
            title: 'Create account',
            subTitle: 'Please enter the credentials to get started.',
          ),

          MyTextField(
            labelText: 'Email address',
            hintText: 'Enter your email',
            controller: _emailController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesEmail, height: 20)],
            ),
          ),
          MyTextField(
            labelText: 'Phone number',
            hintText: '+1 234 567 890',
            controller: _phoneController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesPhone, height: 20)],
            ),
          ),
          MyTextField(
            labelText: 'Create password',
            hintText: '********',
            controller: _passwordController,
            isObSecure: true,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 20)],
            ),
          ),
          Row(
            spacing: 12,
            children: List.generate(
              2,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedRole = index);
                    _authController.selectRole(
                      index == 0 ? UserRole.driver : UserRole.customer,
                    );
                  },
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: index == _selectedRole
                          ? kSecondaryColor.withValues(alpha: .10)
                          : kFillColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: index == _selectedRole
                            ? kSecondaryColor
                            : kFillColor,
                      ),
                    ),
                    child: Center(
                      child: MyText(
                        weight: FontWeight.w500,
                        text: index == 0 ? 'Driver' : 'Customer',
                        color: index == _selectedRole
                            ? kSecondaryColor
                            : kQuaternaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            spacing: 8,
            children: [
              CustomCheckBox(
                isActive: _agree,
                onTap: () {
                  setState(() => _agree = !_agree);
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.Manrope,
                      color: kTertiaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(
                          fontSize: 16,
                          color: kTertiaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontSize: 16,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle Terms & Conditions tap
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            spacing: 8,
            children: [
              CustomCheckBox(
                isActive: _rememberMe,
                onTap: () {
                  setState(() => _rememberMe = !_rememberMe);
                },
              ),
              Expanded(
                child: MyText(
                  text: 'Remember me',
                  size: 16,
                  paddingLeft: 8,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Obx(
            () => MyButton(
              buttonText: 'Continue',
              disabled: _authController.isLoading.value,
              customChild: _authController.isLoading.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: kPrimaryColor,
                      ),
                    )
                  : null,
              onTap: () async {
                // Note: backend does not include driver registration; keeping role selection UI as-is.
                final success = await _authController.register(
                  email: _emailController.text.trim(),
                  password: _passwordController.text,
                  phoneNumber: _phoneController.text.trim(),
                  agreeToPrivacyPolicy: _agree,
                  rememberMe: _rememberMe,
                );
                if (success) {
                  Get.to(() => VerificationCode(email: _emailController.text.trim()));
                }
              },
            ),
          ),
          Obx(
            () => _authController.errorMessage.value.isEmpty
                ? SizedBox.shrink()
                : MyText(
                    text: _authController.errorMessage.value,
                    size: 12,
                    color: Colors.red,
                    paddingTop: 12,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(child: Container(height: 1, color: kBorderColor)),
                MyText(
                  text: 'or sign up',
                  size: 14,
                  color: kQuaternaryColor,
                  paddingLeft: 7,
                  paddingRight: 7,
                ),
                Expanded(child: Container(height: 1, color: kBorderColor)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Image.asset(Assets.imagesGoogle, height: 48),
              Image.asset(Assets.imagesApple, height: 48),
            ],
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              MyText(
                text: "Already have an Account?",
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
                weight: FontWeight.w500,
                color: kSecondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
