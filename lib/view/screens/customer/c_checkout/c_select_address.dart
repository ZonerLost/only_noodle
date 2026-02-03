import 'package:get/get.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/screens/customer/c_checkout/c_checkout.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:only_noodle/controllers/addresses_controller.dart';

class CSelectAddress extends StatelessWidget {
  const CSelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesController());
    return Scaffold(
      appBar: simpleAppBar(title: 'Select Address'),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.addresses.isEmpty) {
            return Center(
              child: MyText(
                text: 'No addresses found.',
                color: kQuaternaryColor,
              ),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: AppSizes.DEFAULT,
            shrinkWrap: true,
            itemCount: controller.addresses.length,
            itemBuilder: (context, idx) {
              final address = controller.addresses[idx];
              return GestureDetector(
                onTap: () async {
                  await controller.setDefault(address.id);
                },
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
                              text: address.label.isNotEmpty
                                  ? address.label
                                  : 'Address',
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                            SizedBox(height: 6),
                            MyText(
                              text: address.displayLine,
                              size: 12,
                              color: kQuaternaryColor,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      if (address.isDefault)
                        Image.asset(Assets.imagesCheck, height: 20),
                    ],
                  ),
                ),
              );
            },
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
