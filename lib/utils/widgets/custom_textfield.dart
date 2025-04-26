import 'package:country_code_picker/country_code_picker.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final String prefixImage;
  final String suffixImage;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Color? color;
  final Widget? suffixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? line;
  final int? maxLength;

  final void Function()? onTap;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.color,
    this.text = '',
    this.prefixImage = '',
    this.suffixImage = '',
    this.focusNode,

    this.keyboardType = TextInputType.text,
    this.line = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (text.isNotEmpty) ...[CustomText(text: text, fontSize: 12), Gap(10)],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLines: line,
          minLines: line,
          maxLength: maxLength,
          onTap: onTap,
          onChanged: onChanged,
          cursorColor: AppColor.blackColor,
          style: TextStyle(color: AppColor.blackColor),

          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon:
                prefixImage == ''
                    ? prefixIcon
                    : customPrefixIcon(image: prefixImage),
            suffixIcon:
                suffixImage == ''
                    ? suffixIcon
                    : customPrefixIcon(image: suffixImage),

            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DM Sans',

              color: color ?? AppColor.greyColor,
            ),

            // filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.themePrimaryColor2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

customPrefixIcon({required String image, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: SvgPicture.asset(image),
    ),
  );
}

class CustomCountyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final void Function(CountryCode) onChanged;
  final String initialSelection;
  const CustomCountyTextfield({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.initialSelection,
  });
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Contact number',
      keyboardType: TextInputType.number,
      controller: controller,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodePicker(
            onChanged: onChanged,
            initialSelection: initialSelection,
            favorite: const ["+91", "IN"],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
          // const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

// class CustomTypeAheadField<T> extends StatelessWidget {
//   final TextEditingController controller;
//   final List<T> Function(String) suggestionsCallback;
//   final void Function(T) onSelected;
//   final String hintText;
//   final Widget Function(BuildContext, T) itemBuilder;

//   const CustomTypeAheadField({
//     super.key,
//     required this.controller,
//     required this.suggestionsCallback,
//     required this.onSelected,
//     required this.hintText,
//     required this.itemBuilder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField<T>(
//       suggestionsCallback: suggestionsCallback,
//       controller: controller,
//       builder: (context, controller, focusNode) {
//         return CustomTextField(
//           controller: controller,
//           hintText: hintText,
//           focusNode: focusNode,
//           suffixIcon: Icon(
//             Icons.arrow_drop_down_rounded,
//             color: AppColor.themePrimary2Color,
//           ),
//         );
//       },
//       itemBuilder: itemBuilder,
//       onSelected: onSelected,
//     );
//   }
// }

// class City {
//   final String name;
//   final String country;

//   City({required this.name, required this.country});
// }

// class CityService {
//   static List<City> cities = [
//     City(name: 'New York', country: 'USA'),
//     City(name: 'London', country: 'UK'),
//     City(name: 'Paris', country: 'France'),
//     City(name: 'Tokyo', country: 'Japan'),
//   ];

//   static List<City> find(String query) {
//     return cities
//         .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
