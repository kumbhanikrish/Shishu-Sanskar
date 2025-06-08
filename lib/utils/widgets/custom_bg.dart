import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

customBg() {
  return Image.asset(
    AppImage.homeBG,
    fit: BoxFit.cover,
    height: 100.h,
    width: 100.w,
  );
}

class CustomToolsTitleBg extends StatelessWidget {
  final Widget? child;
  final String? screenName;
  final String? subTitle;
  const CustomToolsTitleBg({
    super.key,
    this.child,
    this.screenName,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImage.titleBG),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child:
            child ??
            Column(
              children: [
                customAppBar(
                  title: screenName ?? '',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Gap(4.h),

                CustomRowText(
                  text: 'Due Date',

                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  child: CustomText(
                    text: 'Calculator',
                    color: AppColor.themePrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(5),
                CustomText(
                  text: subTitle ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
      ),
    );
  }
}
