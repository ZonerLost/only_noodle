import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:only_noodle/controllers/addresses_controller.dart';

class CAddNewAddress extends StatefulWidget {
  const CAddNewAddress({super.key});

  @override
  State<CAddNewAddress> createState() => _CAddNewAddressState();
}

class _CAddNewAddressState extends State<CAddNewAddress> {
  final AddressesController _controller = Get.put(AddressesController());
  late TextEditingController _labelController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _zipController;
  late TextEditingController _fullController;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _streetController = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    _fullController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _fullController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Add New Address"),
      body: ListView(
        shrinkWrap: true,
        padding: AppSizes.DEFAULT,
        physics: BouncingScrollPhysics(),
        children: [
          MyTextField(
            labelText: "Address Title",
            hintText: 'Home Address',
            controller: _labelController,
          ),
          MyTextField(
            labelText: "Street",
            hintText: 'St 4, Wilson road',
            controller: _streetController,
          ),
          MyTextField(
            labelText: "City",
            hintText: 'California',
            controller: _cityController,
          ),
          MyTextField(
            labelText: "Zip Code",
            hintText: '101223',
            controller: _zipController,
          ),
          MyTextField(
            labelText: "Complete Address",
            hintText: 'St 4, Wilson road, house 34, Brooklyn , USA',
            controller: _fullController,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppSizes.DEFAULT,
        child: Obx(
          () => MyButton(
            buttonText: "Confirm",
            disabled: _controller.isLoading.value,
            customChild: _controller.isLoading.value
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
              await _controller.createAddress(
                label: _labelController.text.trim(),
                street: _streetController.text.trim().isNotEmpty
                    ? _streetController.text.trim()
                    : _fullController.text.trim(),
                city: _cityController.text.trim(),
                zipCode: _zipController.text.trim(),
                deliveryInstructions: '',
              );
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
