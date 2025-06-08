import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final bool overflow;
  final TextDecoration? decoration;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow = false,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColor.blackColor,
        fontFamily: 'Caros Soft',
        decoration: decoration,
      ),

      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow == true ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}

class CustomHTMLText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final bool overflow;

  const CustomHTMLText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.overflow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text.trim(),
      style: {
        "html": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
        "body": Style(
          fontSize: FontSize(fontSize),
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          fontFamily: 'Caros Soft',
          textAlign: textAlign,
          maxLines: maxLines,
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          textOverflow: overflow ? TextOverflow.ellipsis : TextOverflow.visible,
        ),
        "*": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
      },
    );
  }
}

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: 'Not Found!!!',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.subTitleColor,
    );
  }
}

class CustomRowText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;

  final TextDecoration? decoration;
  final Widget? child;
  const CustomRowText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign = TextAlign.left,
    this.maxLines,

    this.decoration,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        CustomText(
          text: text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          textAlign: textAlign,
          maxLines: maxLines,
        ),
        Gap(5),
        child ?? SizedBox(),
      ],
    );
  }
}

// class CustomTitleName extends StatelessWidget {
//   final String title;
//   final String text;
//   final double? width;

//   const CustomTitleName({
//     super.key,
//     required this.title,
//     required this.text,
//     this.width,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(
//           width: width ?? 120,
//           child: CustomText(
//             text: title,
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//         ),
//         const CustomText(text: ':', fontWeight: FontWeight.w600, fontSize: 14),
//         const Gap(5),
//         Expanded(
//           child: CustomText(
//             text: text,
//             color: AppColor.themePrimary2Color,
//             fontSize: 12,
//             overflow: true,
//           ),
//         ),
//       ],
//     );
//   }
// }
