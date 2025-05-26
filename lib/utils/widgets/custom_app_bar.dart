// import 'package:flutter/material.dart';
// import 'package:shishu_sanskar/utils/theme/colors.dart';
// import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;
//   final double? fontSize;
//   final bool? centerTitle;
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.leading,
//     this.actions,
//     this.bottom,
//     this.fontSize,
//     this.centerTitle,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: AppColor.borderColor,
//             offset: Offset(0, -1),
//             blurRadius: 80,
//             spreadRadius: 10,
//           ),
//         ],
//         border: Border(
//           bottom: BorderSide(width: 0.1, color: AppColor.whiteColor),
//         ),
//       ),
//       child: AppBar(
//         title: CustomText(
//           text: title,
//           color: AppColor.themePrimary2Color,
//           fontWeight: FontWeight.w600,
//           fontSize: fontSize ?? 18,
//         ),
//         bottom: bottom,
//         leading: leading,
//         actions: actions,
//         automaticallyImplyLeading: true,
//         centerTitle: centerTitle ?? true,
//         iconTheme: IconThemeData(color: AppColor.themePrimary2Color),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

customAppBar({
  required String title,
  required void Function() onTap,
  bool topGap = true,
}) {
  return Column(
    children: [
      if (topGap == true) ...[Gap(5.h)],

      Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 14,
          right: 20,
          left: 20,
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 10),
                child: SvgPicture.asset(AppImage.back, height: 12),
              ),
            ),

            CustomText(text: title, fontWeight: FontWeight.w600, fontSize: 22),
          ],
        ),
      ),
    ],
  );
}

customAppBar2() {
  
}
