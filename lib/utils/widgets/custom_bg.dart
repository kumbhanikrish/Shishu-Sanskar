import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:sizer/sizer.dart';

customBg() {
  return Image.asset(
    AppImage.homeBG,
    fit: BoxFit.cover,
    height: 100.h,
    width: 100.w,
  );
}
