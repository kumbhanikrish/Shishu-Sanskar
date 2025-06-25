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
  final Widget? leading;
  final bool? image;
  const CustomListTile({
    super.key,
    required this.text,
    required this.leadingImage,
    this.onTap,
    this.image,
    this.subtitle,
    this.leading,
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
      child: Container(
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.zero, // No outer padding
        child: ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding:
              contentPadding ??
              EdgeInsets.zero, // Removes internal content padding
          dense: true, // Makes ListTile tighter
          leading:
              leadingImage.isEmpty
                  ? leading
                  : image == true
                  ? Image.asset(
                    leadingImage,
                    color: leadingColor,
                    height: height ?? 20,
                  )
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
      ),
    );
  }
}
