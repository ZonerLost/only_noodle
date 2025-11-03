import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_checkout.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

class CSelectAddress extends StatelessWidget {
  const CSelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Select Address'),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: AppSizes.DEFAULT,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, idx) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: kFillColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Home Address',
                          size: 16,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(height: 6),
                        MyText(
                          text: 'St3, Wilson road, Brooklyn, USA 10121',
                          size: 12,
                          color: kQuaternaryColor,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  if (idx == 0) Image.asset(Assets.imagesCheck, height: 20),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: MyButton(
          buttonText: 'Continue',
          onTap: () {
            Get.to(() => CCheckout());
          },
        ),
      ),
    );
  }
}
