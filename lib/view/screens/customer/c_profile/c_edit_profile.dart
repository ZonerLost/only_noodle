import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/main.dart';
import 'package:only_noodle/view/widget/common_image_view_widget.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';

class CEditProfile extends StatelessWidget {
  const CEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Edit Profile"),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CommonImageView(
                      height: 90,
                      width: 90,
                      radius: 100.0,
                      url: dummyImg,
                    ),
                    Image.asset(Assets.imagesOverlyCamera, height: 90),
                  ],
                ),
              ),
              MyText(
                paddingTop: 16,
                text: 'Upload Profile Photo',
                size: 16,
                weight: FontWeight.w500,
                paddingBottom: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: List.generate(2, (index) {
                  final label = index == 0 ? 'Remove photo' : 'Change Photo';
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: index == 1
                            ? kSecondaryColor.withValues(alpha: .12)
                            : kFillColor,
                        border: Border.all(
                          color: index == 1 ? kSecondaryColor : kFillColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: MyText(
                          text: label,
                          weight: FontWeight.w500,
                          color: index == 1
                              ? kSecondaryColor
                              : kQuaternaryColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          MyText(
            text: 'PERSONAL INFORMATION',
            size: 12,
            weight: FontWeight.w500,
            color: kQuaternaryColor,
            paddingTop: 26,
            letterSpacing: 1.0,
            paddingBottom: 10,
          ),
          MyTextField(labelText: "Full Name", hintText: 'Christopher Henry'),
          MyTextField(
            labelText: "Email Address",
            hintText: 'christop234@gmail.com',
          ),
          MyTextField(
            labelText: "Phone Number",
            hintText: '+1 (566) 456456 56',
          ),
          MyTextField(
            labelText: "Address",
            hintText: 'St3 Wilson road , California , USA',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: MyButton(
          buttonText: "Update",
          onTap: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
