import 'package:only_noodle/view/screens/auth/login/login.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/heading_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _tokenController;
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _tokenController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
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
            title: 'Reset Password',
            subTitle:
                'Please create your new password. Do not share with anyone in your circle.',
          ),
          MyTextField(
            labelText: 'Reset Token',
            hintText: 'Paste token from email',
            controller: _tokenController,
          ),
          MyTextField(
            labelText: 'Create new password',
            hintText: '********',
            isObSecure: true,
            controller: _passwordController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 20)],
            ),
          ),
          MyTextField(
            labelText: 'Confirm new password',
            hintText: '********',
            isObSecure: true,
            controller: _emailController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 20)],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: Obx(
          () => MyButton(
            buttonText: 'Reset Password',
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
              if (_passwordController.text != _emailController.text) {
                Get.snackbar(
                  'Passwords do not match',
                  'Please make sure both passwords are the same.',
                );
                return;
              }
              final success = await _authController.resetPassword(
                token: _tokenController.text.trim(),
                newPassword: _passwordController.text,
              );
              if (success) {
                Get.offAll(() => Login());
              }
            },
          ),
        ),
      ),
    );
  }
}
