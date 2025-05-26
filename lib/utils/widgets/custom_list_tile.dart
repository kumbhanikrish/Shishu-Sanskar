import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String text;

  final Color? tileColor;
  final String leadingImage;
  final void Function()? onTap;
  final Color? leadingColor;
  final Color? trailingColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? trailing;
  final Color? textColor;
  final FontWeight? fontWeight;
  final Widget? subtitle;
  final double? fontSize;
  final double? height;
  const CustomListTile({
    super.key,
    required this.text,
    required this.leadingImage,
    this.onTap,
    this.subtitle,
    this.contentPadding,
    this.height,
    this.leadingColor,
    this.trailing,
    this.tileColor,
    this.trailingColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColor.greyColor,
      highlightColor: AppColor.greyColor,
      borderRadius: BorderRadius.circular(12),

      child: ListTile(
        tileColor: tileColor,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        leading:
            leadingImage.isEmpty
                ? null
                : SvgPicture.asset(
                  leadingImage,
                  color: leadingColor,
                  height: height ?? 20,
                ),
        trailing:
            trailing ??
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: trailingColor ?? AppColor.themePrimaryColor,
            ),
        title: CustomText(
          text: text,
          fontSize: fontSize ?? 10,
          color: textColor ?? AppColor.blackColor,

          fontWeight: fontWeight ?? FontWeight.w400,
        ),
        subtitle: subtitle,
      ),
    );
  }
}
