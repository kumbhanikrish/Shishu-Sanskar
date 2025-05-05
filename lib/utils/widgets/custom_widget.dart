import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:sizer/sizer.dart';

customDivider() {
  return Column(
    children: [
      Gap(20),
      
      Container(height: 0.5, width: 100.w, color: AppColor.unselectedColor),
      Gap(20),
    ],
  );
}
