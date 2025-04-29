import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

customTitleAnsSeeAll({
  required String title,
  required void Function() onTap,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: title,
            fontSize: fontSize ?? 12,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? AppColor.seeAllTitleColor,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 14, right: 20),
            child: SvgPicture.asset(AppImage.seeAll),
          ),
        ),
      ],
    ),
  );
}

Widget bottomBarTab(
  BuildContext context, {
  required int currentIndex,
  required int index,
  required String icon,
  required String label,
}) {
  bool isSelected = currentIndex == index;
  Color selectedColor = AppColor.themeSecondaryColor;
  Color unselectedColor = AppColor.unselectedColor;
  BottomBarCubit bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);

  return InkWell(
    onTap: () {
      bottomBarCubit.changeTab(index);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          color: isSelected ? selectedColor : unselectedColor,
        ),
        Gap(5),
        CustomText(
          text: label,
          fontSize: 10,
          color: isSelected ? selectedColor : unselectedColor,
        ),
      ],
    ),
  );
}

customCardView({
  required String image,
  double? height,
  double? width,
  required String title,
  required void Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 7),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomCachedImage(imageUrl: image),
          ),

          Gap(5),
          CustomText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
        ],
      ),
    ),
  );
}
