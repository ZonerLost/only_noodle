import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_sizes.dart';
import 'package:only_noodle/view/widget/custom_app_bar.dart';
import 'package:only_noodle/view/widget/custom_check_box_widget.dart';
import 'package:only_noodle/view/widget/my_button_widget.dart';
import 'package:only_noodle/view/widget/my_text_field_widget.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:only_noodle/controllers/addresses_controller.dart';
import 'package:only_noodle/models/address.dart';

class CAddNewAddress extends StatefulWidget {
  const CAddNewAddress({super.key, this.address});

  final Address? address;

  @override
  State<CAddNewAddress> createState() => _CAddNewAddressState();
}

class _CAddNewAddressState extends State<CAddNewAddress> {
  final AddressesController _controller = Get.put(AddressesController());
  late TextEditingController _labelController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _zipController;
  late TextEditingController _countryController;
  late TextEditingController _instructionsController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _streetController = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    _countryController = TextEditingController();
    _instructionsController = TextEditingController();
    final address = widget.address;
    if (address != null) {
      _labelController.text = address.label;
      _streetController.text = address.street;
      _cityController.text = address.city;
      _zipController.text = address.zipCode;
      _countryController.text = address.country;
      _instructionsController.text = address.deliveryInstructions;
      _isDefault = address.isDefault;
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _countryController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        title: widget.address == null ? "Add New Address" : "Edit Address",
      ),
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
            labelText: "Country",
            hintText: 'PK',
            controller: _countryController,
          ),
          MyTextField(
            labelText: "Delivery Instructions",
            hintText: 'Apartment, floor, notes...',
            controller: _instructionsController,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CustomCheckBox(
                isActive: _isDefault,
                onTap: () => setState(() => _isDefault = !_isDefault),
              ),
              Expanded(
                child: MyText(
                  text: 'Set as default',
                  size: 16,
                  paddingLeft: 8,
                  weight: FontWeight.w500,
                ),
              ),
            ],
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
              if (widget.address == null) {
                await _controller.createAddress(
                  label: _labelController.text.trim(),
                  street: _streetController.text.trim(),
                  city: _cityController.text.trim(),
                  zipCode: _zipController.text.trim(),
                  country: _countryController.text.trim().isEmpty
                      ? null
                      : _countryController.text.trim(),
                  deliveryInstructions: _instructionsController.text.trim(),
                  isDefault: _isDefault,
                );
              } else {
                await _controller.updateAddress(
                  id: widget.address!.id,
                  label: _labelController.text.trim(),
                  street: _streetController.text.trim(),
                  city: _cityController.text.trim(),
                  zipCode: _zipController.text.trim(),
                  country: _countryController.text.trim().isEmpty
                      ? null
                      : _countryController.text.trim(),
                  deliveryInstructions: _instructionsController.text.trim(),
                  isDefault: _isDefault,
                );
              }
              if (_controller.errorMessage.value.isEmpty) {
                Get.back(result: true);
              } else {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_controller.errorMessage.value)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
