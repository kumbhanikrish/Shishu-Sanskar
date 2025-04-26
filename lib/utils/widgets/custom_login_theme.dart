import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:sizer/sizer.dart';

customLoginTheme({required Widget child}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 100.w,
        height: 35.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.loginBGImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Center(child: Image.asset(AppLogo.splashLogo, height: 12.h)),
        ),
      ),

      Padding(
        padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
        child: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.whiteColor.withOpacity(0.3),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: 21.5.h,
          right: 7.w,
          left: 7.w,
          bottom: 4.h,
        ),
        child: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.whiteColor,
          ),
          child: child,
        ),
      ),
    ],
  );
}
