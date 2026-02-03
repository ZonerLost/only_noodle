import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:get/get.dart';
import 'package:only_noodle/services/service_locator.dart';
import 'package:only_noodle/view/screens/auth/auth_controller/auth_controller.dart';
import 'package:only_noodle/view/screens/driver/d_home/d_home.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';

class DriverCompleteProfile extends StatefulWidget {
  const DriverCompleteProfile({super.key});

  @override
  State<DriverCompleteProfile> createState() => _DriverCompleteProfileState();
}

class _DriverCompleteProfileState extends State<DriverCompleteProfile> {
  final AuthController _authController = Get.find<AuthController>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

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
          MyTextField(
            labelText: 'Full Name',
            hintText: 'Chris Henry',
            controller: _nameController,
          ),
          MyTextField(
            labelText: 'Phone number',
            hintText: '+1 (566) 456456 56',
            controller: _phoneController,
          ),
          MyTextField(
            labelText: 'Address',
            hintText: 'St3 Wilson road , California , USA',
            controller: _addressController,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: Obx(
          () => MyButton(
            buttonText: 'Confirm',
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
              await ServiceLocator.driverService.updateProfile(
                name: _nameController.text.trim(),
                phone: _phoneController.text.trim(),
              );
              Get.offAll(() => DHome());
            },
          ),
        ),
      ),
    );
  }
}
