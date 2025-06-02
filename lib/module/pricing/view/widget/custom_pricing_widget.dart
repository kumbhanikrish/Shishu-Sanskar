import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

customPricingCard({
  required String image,
  required String name,
  required String price,
  required void Function() onTap,
  required Widget child,
  Color? backgroundColor,
  Color? borderColor,
  Color? textColor,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(color: AppColor.themePrimaryColor, width: 1),
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(image),
        Gap(10),
        CustomText(text: name, fontSize: 20),
        CustomText(text: price, fontSize: 40, fontWeight: FontWeight.w600),
        Gap(10),
        CustomButton(
          text: 'Choose Plan',
          onTap: onTap,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          textColor: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          borderRadius: BorderRadius.circular(80),
        ),
        Gap(20),
        CustomText(text: 'Additional Services', fontWeight: FontWeight.w600),
        Gap(8),
        child,
      ],
    ),
  );
}

customDoneIconAndText({IconData? icon, Color? color, required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: <Widget>[
        Icon(
          icon ?? Icons.done_rounded,
          color: color ?? AppColor.themePrimaryColor,
          size: 14,
        ),
        Gap(7),
        CustomText(text: text, fontSize: 14),
      ],
    ),
  );
}

pricingTextWithAmount({
  required String text,
  required String amount,
  Color? color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CustomText(text: text, fontSize: 12),
      CustomText(
        text: amount,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color ?? AppColor.seeAllTitleColor,
      ),
    ],
  );
}
