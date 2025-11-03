import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/customer/c_nav_bar/c_nav_bar.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class CustomerCompleteProfile extends StatelessWidget {
  const CustomerCompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Complete your profile'),
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
                Image.asset(Assets.imagesProfilePhoto, height: 80),
                MyText(
                  paddingTop: 16,
                  text: 'Upload Profile Photo',
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          MyText(
            paddingTop: 16,
            text: 'CONTACT INFORMATION',
            paddingBottom: 10,
            size: 12,
            weight: FontWeight.w500,
          ),
          MyTextField(labelText: 'Full Name', hintText: 'Chris Henry'),
          MyTextField(labelText: 'Address Title', hintText: 'Home Address'),
          MyTextField(labelText: 'Zip Code', hintText: '101223'),
          MyTextField(
            labelText: 'Complete Address',
            hintText: 'St3 Wilson road , California , USA',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: MyButton(
          buttonText: 'Confirm',
          onTap: () {
            Get.to(() => CBottomNavBar());
          },
        ),
      ),
    );
  }
}
