import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Change Password'),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          MyTextField(
            labelText: 'Current Password',
            hintText: '********',
            isObSecure: true,
            controller: _emailController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 24)],
            ),
          ),
          MyTextField(
            labelText: 'Create new password',
            hintText: '********',
            isObSecure: true,
            controller: _passwordController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 24)],
            ),
          ),
          MyTextField(
            labelText: 'Confirm new password',
            hintText: '********',
            isObSecure: true,
            controller: _confirmController,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(Assets.imagesVisibility, height: 24)],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: Obx(
          () => MyButton(
            buttonText: 'Update',
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
              if (_passwordController.text != _confirmController.text) {
                Get.snackbar(
                  'Passwords do not match',
                  'Please make sure both passwords are the same.',
                );
                return;
              }
              final success = await _authController.changePassword(
                currentPassword: _emailController.text,
                newPassword: _passwordController.text,
                confirmPassword: _confirmController.text,
              );
              if (success) {
                Get.back();
              }
            },
          ),
        ),
      ),
    );
  }
}
