import 'dart:async';
import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/view/screens/auth/login/login.dart';
import 'package:only_noodle/view/screens/customer/c_nav_bar/c_nav_bar.dart';
import 'package:only_noodle/view/screens/driver/d_home/d_home.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  void splashScreenHandler() {
    Timer(Duration(milliseconds: 1200), () {
      final storage = ServiceLocator.authStorage;
      final rememberMe = storage.rememberMe;
      final token = storage.accessToken;
      final role = storage.role;

      if (rememberMe && token != null && token.isNotEmpty) {
        if (role == 'driver') {
          Get.offAll(() => DHome());
        } else {
          Get.offAll(() => CBottomNavBar());
        }
        return;
      }

      Get.offAll(() => Login());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      child: Padding(
        padding: AppSizes.DEFAULT,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(text: '', size: 16),
            Column(
              children: [
                Center(child: Image.asset(Assets.imagesLogo, height: 105)),
                SizedBox(height: 12),
                Center(child: Image.asset(Assets.imagesOnlyNoodle, height: 36)),
              ],
            ),
            MyText(
              text: 'Powered by Only Noodle',
              size: 16,
              textAlign: TextAlign.center,
              weight: FontWeight.w500,
              color: kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
