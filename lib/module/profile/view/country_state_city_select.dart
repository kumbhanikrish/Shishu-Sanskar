import 'dart:developer';

import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bottomsheet.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';

class LocationPicker extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController cityController;
  final String city;
  final String state;
  final String country;

  const LocationPicker({
    super.key,
    required this.countryController,
    required this.stateController,
    required this.cityController,
    required this.state,
    required this.city,
    required this.country,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String? countryValue;
  String? stateValue;
  String? cityValue;
  @override
  void initState() {
    countryValue =
        widget.countryController.text.isNotEmpty
            ? widget.countryController.text
            : widget.country;
    stateValue =
        widget.stateController.text.isNotEmpty
            ? widget.stateController.text
            : widget.state;
    cityValue =
        widget.cityController.text.isNotEmpty
            ? widget.cityController.text
            : widget.city;

    widget.cityController.text = widget.city;
    widget.stateController.text = widget.state;
    widget.countryController.text = widget.country;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('widget.citywidget.city ::${widget.city}');
    return Column(
      children: [
        /// Country Field
        CustomTextField(
          text: 'Country',
          hintText: "Select Country",
          controller: widget.countryController,
          readOnly: true,
          onTap: () => _showCSCPicker(),
        ),
        const SizedBox(height: 16),

        /// State Field
        CustomTextField(
          text: 'State',
          hintText: "Select State",
          controller: widget.stateController,
          readOnly: true,
          onTap: () => _showCSCPicker(),
        ),
        const SizedBox(height: 16),

        /// City Field
        CustomTextField(
          text: 'City',
          hintText: "Select City",
          controller: widget.cityController,
          readOnly: true,
          onTap: () => _showCSCPicker(),
        ),
      ],
    );
  }

  void _showCSCPicker() {
    customBottomSheet(
      context,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 350,
          child: CSCPickerPlus(
            showStates: true,
            showCities: true,
            flagState: CountryFlag.ENABLE,
            currentCountry: countryValue,
            currentState: stateValue,
            currentCity: cityValue,

            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.themePrimaryColor2),
            ),
            disabledDropdownDecoration: BoxDecoration(
              color: AppColor.datePickerBk,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.themePrimaryColor2),
            ),

            onCountryChanged: (value) {
              setState(() {
                countryValue = value;
                widget.countryController.text = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value;
                widget.stateController.text = value ?? '';
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value;
                widget.cityController.text = value ?? '';
              });
            },
          ),
        ),
      ),
    );
  }
}
