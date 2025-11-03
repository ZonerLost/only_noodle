import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:get/get.dart';

class CAddNewAddress extends StatelessWidget {
  const CAddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Add New Address"),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          MyTextField(labelText: "Address Title", hintText: 'Home Address'),
          MyTextField(labelText: "Street", hintText: 'St 4, Wilson road'),
          MyTextField(labelText: "State", hintText: 'California , USA'),
          MyTextField(labelText: "Zip Code", hintText: '101223'),
          MyTextField(
            labelText: "Complete Address",
            hintText: 'St 4, Wilson road, house 34, Brooklyn , USA',
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: MyButton(
          buttonText: "Confirm",
          onTap: () {
            Get.back();
          },
        ),
      ),
    );
  }
}
