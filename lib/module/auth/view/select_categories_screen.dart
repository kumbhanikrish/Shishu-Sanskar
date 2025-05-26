import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SelectCategoriesScreen extends StatelessWidget {
  final void Function() onTap;
  final void Function() backOnTap;

  final ValueNotifier<String> planningCoupleDate;
  final ValueNotifier<String> pregnantMotherDate;
  const SelectCategoriesScreen({
    super.key,
    required this.onTap,
    required this.backOnTap,
    required this.planningCoupleDate,
    required this.pregnantMotherDate,
  });
  @override
  Widget build(BuildContext context) {
    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomText(
              text: 'Select categories',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text: 'choose category',
              fontSize: 12,
              color: AppColor.subTitleColor,
            ),
            Gap(3.6.h),

            BlocBuilder<CategoryRadioCubit, int>(
              builder: (context, selectedCategory) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Select Categories', fontSize: 12),
                    Gap(10),

                    customGenderRadio(
                      fillImage:
                          selectedCategory == 1
                              ? AppImage.fillCircle
                              : AppImage.circle,
                      buttonImage:
                          selectedCategory == 1
                              ? AppImage.colorCircle
                              : AppImage.circle,
                      genderIcon: '',
                      title: 'Wellness Seekers',
                      onTap: () {
                        categoryRadioCubit.selectCategory(1);
                      },
                    ),
                    Gap(10),
                    customGenderRadio(
                      fillImage:
                          selectedCategory == 2
                              ? AppImage.fillCircle
                              : AppImage.circle,
                      buttonImage:
                          selectedCategory == 2
                              ? AppImage.colorCircle
                              : AppImage.circle,
                      onTap: () {
                        pregnantMotherDate.value = 'dd/mm/yyyy';
                        categoryRadioCubit.selectCategory(2);
                      },
                      genderIcon: '',
                      title: 'Planning Couple',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(text: 'LMP', fontSize: 12),
                                  CustomText(
                                    text: '(last menstrual period)',
                                    fontSize: 10,
                                    color: AppColor.subTitleColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.datePickerBk,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                onTap:
                                    selectedCategory != 2
                                        ? () {}
                                        : () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );

                                          log(
                                            'pickedDatepickedDate ::$pickedDate',
                                          );
                                          if (pickedDate != null) {
                                            planningCoupleDate
                                                .value = DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(pickedDate);

                                            log(
                                              'planningCoupleDateplanningCoupleDate ::$planningCoupleDate',
                                            );
                                          }
                                        },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder<String>(
                                        valueListenable: planningCoupleDate,
                                        builder: (context, value, child) {
                                          return CustomText(
                                            text: value,
                                            fontSize: 10,
                                          );
                                        },
                                      ),
                                      Gap(10),
                                      SvgPicture.asset(AppImage.calendar),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
                    customGenderRadio(
                      genderIcon: '',
                      fillImage:
                          selectedCategory == 3
                              ? AppImage.fillCircle
                              : AppImage.circle,
                      buttonImage:
                          selectedCategory == 3
                              ? AppImage.colorCircle
                              : AppImage.circle,
                      onTap: () {
                        planningCoupleDate.value = 'dd/mm/yyyy';
                        categoryRadioCubit.selectCategory(3);
                      },
                      title: 'Pregnant Mother',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(text: 'LMP', fontSize: 12),
                                  CustomText(
                                    text: '(last menstrual period)',
                                    fontSize: 10,
                                    color: AppColor.subTitleColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.datePickerBk,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                onTap:
                                    selectedCategory != 3
                                        ? () {}
                                        : () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100),
                                              );
                                          if (pickedDate != null) {
                                            pregnantMotherDate
                                                .value = DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(pickedDate);
                                          }
                                        },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                    horizontal: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      ValueListenableBuilder<String>(
                                        valueListenable: pregnantMotherDate,
                                        builder: (context, value, child) {
                                          return CustomText(
                                            text:
                                                value == ''
                                                    ? 'dd/mm/yyyy'
                                                    : value,
                                            fontSize: 10,
                                          );
                                        },
                                      ),
                                      Gap(10),
                                      SvgPicture.asset(AppImage.calendar),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
                    customGenderRadio(
                      genderIcon: '',
                      title: 'Miscarriage',

                      fillImage:
                          selectedCategory == 4
                              ? AppImage.fillCircle
                              : AppImage.circle,
                      buttonImage:
                          selectedCategory == 4
                              ? AppImage.colorCircle
                              : AppImage.circle,
                      onTap: () {
                        categoryRadioCubit.selectCategory(4);
                      },
                    ),
                    Gap(20),
                    CustomButton(text: 'Done', onTap: onTap),

                    Align(
                      child: CustomTextButton(
                        text: 'Back',
                        onPressed: backOnTap,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
