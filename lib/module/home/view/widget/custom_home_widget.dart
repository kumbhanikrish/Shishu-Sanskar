import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/blog/cubit/blog_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
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
  BlogCubit blogCubit = BlocProvider.of<BlogCubit>(context);
  PricingCubit pricingCubit = BlocProvider.of<PricingCubit>(context);

  return BlocBuilder<CategoryRadioCubit, int>(
    builder: (context, state) {
      return InkWell(
        onTap: () async {
          log('indexindex ::$index');
          if (index == 1) {
            blogCubit.getBlogs(context, search: '', isRefresh: true);
          } else if (index == 3) {
            pricingCubit.getPlans(context, categoryId: state.toString());
          }
          bottomBarCubit.changeTab(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
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
        ),
      );
    },
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
            child: CustomCachedImage(
              imageUrl: image,
              height: height,
              width: width,
            ),
          ),

          Gap(5),
          CustomText(text: title, fontSize: 10, fontWeight: FontWeight.w600),
        ],
      ),
    ),
  );
}

customEventCardView({
  required void Function() onTap,
  required String title,
  required String subTitle,
  required String date,
  required String time,
  double? mainWidth,
  double? mainHeight,
  bool showButton = true,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(right: showButton == true ? 7 : 0),
      child: Container(
        width: mainWidth ?? 100.w,
        height: mainHeight ?? 30.h,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border.all(color: AppColor.themePrimaryColor2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomCachedImage(
                      width: 40.w,
                      height: 100.h,

                      imageUrl:
                          'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            AppImage.eventBG,
                            width: 40.w,
                            height: 30.h,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: 40.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColor.whiteColor.withOpacity(0.2),
                                  AppColor.whiteColor,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 14,
                    right: 14,
                    bottom: 14,
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(6),
                      CustomText(
                        text: subTitle,
                        fontSize: 10,

                        color: AppColor.seeAllTitleColor,
                      ),
                      Gap(10),
                      customIconAndText(date: date, time: time),
                      if (showButton == true) ...[
                        Spacer(),
                        CustomButton(
                          text: 'Register',
                          onTap: () {},
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

customIconAndText({required String date, required String time}) {
  return Column(
    children: [
      Row(
        children: <Widget>[
          SvgPicture.asset(
            height: 10,
            width: 10,
            AppImage.calendar,
            color: AppColor.themeSecondaryColor,
          ),
          Gap(5),

          CustomText(text: date, fontSize: 10),
        ],
      ),
      Gap(10),
      Row(
        children: <Widget>[
          SvgPicture.asset(AppImage.clock, height: 10, width: 10),
          Gap(5),
          CustomText(text: time, fontSize: 10),
        ],
      ),
    ],
  );
}
