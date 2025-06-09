import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/auth_category_model.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SelectCategoriesScreen extends StatelessWidget {
  final void Function() onTap;
  final void Function() backOnTap;

  const SelectCategoriesScreen({
    super.key,
    required this.onTap,
    required this.backOnTap,
  });
  @override
  Widget build(BuildContext context) {
    String planningCoupleValue = '';
    String pregnantMotherValue = '';
    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);
    DatePicker2Cubit datePicker2Cubit = BlocProvider.of<DatePicker2Cubit>(
      context,
    );
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    List<AuthCategoryModel> authCategoryList = [];
    authCubit.authCategory(context);

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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthCategoryState) {
                          authCategoryList = state.authCategoryList;
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: authCategoryList.length,

                          itemBuilder: (context, index) {
                            AuthCategoryModel authCategoryModel =
                                authCategoryList[index];
                            return customGenderRadio(
                              fillImage:
                                  selectedCategory == authCategoryModel.id
                                      ? AppImage.fillCircle
                                      : AppImage.circle,
                              buttonImage:
                                  selectedCategory == authCategoryModel.id
                                      ? AppImage.colorCircle
                                      : AppImage.circle,
                              genderIcon: '',
                              title: authCategoryModel.name,
                              onTap: () {
                                categoryRadioCubit.selectCategory(
                                  authCategoryModel.id,
                                );
                              },
                              child:
                                  authCategoryModel.id == 2 ||
                                          authCategoryModel.id == 3
                                      ? BlocBuilder<DatePickerCubit, DateTime?>(
                                        builder: (context, planningCouple) {
                                          String formattedDate = '';

                                          if (planningCouple != null) {
                                            formattedDate = DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(planningCouple);
                                          }
                                          if (planningCoupleValue !=
                                              formattedDate) {
                                            planningCoupleValue = formattedDate;
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      CustomText(
                                                        text: 'LMP',
                                                        fontSize: 12,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            '(last menstrual period)',
                                                        fontSize: 10,
                                                        color:
                                                            AppColor
                                                                .subTitleColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColor.datePickerBk,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      customDatePicker(
                                                        context,
                                                        value: [planningCouple],
                                                        onValueChanged: (
                                                          value,
                                                        ) {
                                                          datePickerCubit
                                                              .selectDate(
                                                                context,
                                                                value.first,
                                                              );
                                                        },
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 14,
                                                            horizontal: 10,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                planningCoupleValue ==
                                                                        ''
                                                                    ? 'dd/mm/yyyy'
                                                                    : planningCoupleValue,
                                                            fontSize: 10,
                                                          ),
                                                          Gap(10),
                                                          SvgPicture.asset(
                                                            AppImage.calendar,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                      : SizedBox(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(10);
                          },
                        );
                      },
                    ),

                    // customGenderRadio(
                    //   fillImage:
                    //       selectedCategory == 1
                    //           ? AppImage.fillCircle
                    //           : AppImage.circle,
                    //   buttonImage:
                    //       selectedCategory == 1
                    //           ? AppImage.colorCircle
                    //           : AppImage.circle,
                    //   genderIcon: '',
                    //   title: 'Wellness Seekers',
                    //   onTap: () {
                    //     categoryRadioCubit.selectCategory(1);
                    //   },
                    // ),
                    // Gap(10),
                    // BlocBuilder<DatePickerCubit, DateTime?>(
                    //   builder: (context, planningCouple) {
                    //     String formattedDate = '';

                    //     if (planningCouple != null) {
                    //       formattedDate = DateFormat(
                    //         'dd/MM/yyyy',
                    //       ).format(planningCouple);
                    //     }
                    //     if (planningCoupleValue != formattedDate) {
                    //       planningCoupleValue = formattedDate;
                    //     }
                    //     return customGenderRadio(
                    //       fillImage:
                    //           selectedCategory == 2
                    //               ? AppImage.fillCircle
                    //               : AppImage.circle,
                    //       buttonImage:
                    //           selectedCategory == 2
                    //               ? AppImage.colorCircle
                    //               : AppImage.circle,
                    //       onTap: () {
                    //         datePicker2Cubit.init();

                    //         categoryRadioCubit.selectCategory(2);
                    //       },
                    //       genderIcon: '',
                    //       title: 'Planning Couple',
                    //       child:
                    //           selectedCategory != 2
                    //               ? SizedBox()
                    //               : Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                   vertical: 10,
                    //                 ),
                    //                 child: Row(
                    //                   children: <Widget>[
                    //                     Expanded(
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: <Widget>[
                    //                           CustomText(
                    //                             text: 'LMP',
                    //                             fontSize: 12,
                    //                           ),
                    //                           CustomText(
                    //                             text: '(last menstrual period)',
                    //                             fontSize: 10,
                    //                             color: AppColor.subTitleColor,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                         color: AppColor.datePickerBk,
                    //                         borderRadius: BorderRadius.circular(
                    //                           5,
                    //                         ),
                    //                       ),
                    //                       child: InkWell(
                    //                         onTap:
                    //                             selectedCategory != 2
                    //                                 ? () {}
                    //                                 : () async {
                    //                                   customDatePicker(
                    //                                     context,
                    //                                     value: [planningCouple],
                    //                                     onValueChanged: (
                    //                                       value,
                    //                                     ) {
                    //                                       datePickerCubit
                    //                                           .selectDate(
                    //                                             context,
                    //                                             value.first,
                    //                                           );
                    //                                     },
                    //                                   );
                    //                                 },
                    //                         child: Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                 vertical: 14,
                    //                                 horizontal: 10,
                    //                               ),
                    //                           child: Row(
                    //                             children: [
                    //                               CustomText(
                    //                                 text:
                    //                                     planningCoupleValue ==
                    //                                             ''
                    //                                         ? 'dd/mm/yyyy'
                    //                                         : planningCoupleValue,
                    //                                 fontSize: 10,
                    //                               ),
                    //                               Gap(10),
                    //                               SvgPicture.asset(
                    //                                 AppImage.calendar,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //     );
                    //   },
                    // ),
                    // Gap(10),
                    // BlocBuilder<DatePicker2Cubit, DateTime?>(
                    //   builder: (context, pregnantMother) {
                    //     String formattedDate = '';

                    //     log('pregnantMotherpregnantMother ::$pregnantMother');

                    //     if (pregnantMother != null) {
                    //       formattedDate = DateFormat(
                    //         'dd/MM/yyyy',
                    //       ).format(pregnantMother);
                    //     }

                    //     if (pregnantMotherValue != formattedDate) {
                    //       pregnantMotherValue = formattedDate;
                    //     }
                    //     return customGenderRadio(
                    //       genderIcon: '',
                    //       fillImage:
                    //           selectedCategory == 3
                    //               ? AppImage.fillCircle
                    //               : AppImage.circle,
                    //       buttonImage:
                    //           selectedCategory == 3
                    //               ? AppImage.colorCircle
                    //               : AppImage.circle,
                    //       onTap: () {
                    //         datePickerCubit.init();

                    //         categoryRadioCubit.selectCategory(3);
                    //       },
                    //       title: 'Pregnant Mother',
                    //       child:
                    //           selectedCategory != 3
                    //               ? SizedBox()
                    //               : Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                   vertical: 10,
                    //                 ),
                    //                 child: Row(
                    //                   children: <Widget>[
                    //                     Expanded(
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: <Widget>[
                    //                           CustomText(
                    //                             text: 'LMP',
                    //                             fontSize: 12,
                    //                           ),
                    //                           CustomText(
                    //                             text: '(last menstrual period)',
                    //                             fontSize: 10,
                    //                             color: AppColor.subTitleColor,
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                         color: AppColor.datePickerBk,
                    //                         borderRadius: BorderRadius.circular(
                    //                           5,
                    //                         ),
                    //                       ),
                    //                       child: InkWell(
                    //                         onTap:
                    //                             selectedCategory != 3
                    //                                 ? () {}
                    //                                 : () async {
                    //                                   customDatePicker(
                    //                                     context,
                    //                                     value: [pregnantMother],
                    //                                     onValueChanged: (
                    //                                       value,
                    //                                     ) {
                    //                                       log('value ::$value');
                    //                                       datePicker2Cubit
                    //                                           .selectDate(
                    //                                             context,
                    //                                             value.first,
                    //                                           );
                    //                                     },
                    //                                   );
                    //                                 },
                    //                         child: Padding(
                    //                           padding:
                    //                               const EdgeInsets.symmetric(
                    //                                 vertical: 14,
                    //                                 horizontal: 10,
                    //                               ),
                    //                           child: Row(
                    //                             children: [
                    //                               CustomText(
                    //                                 text:
                    //                                     pregnantMotherValue ==
                    //                                             ''
                    //                                         ? 'dd/mm/yyyy'
                    //                                         : pregnantMotherValue,
                    //                                 fontSize: 10,
                    //                               ),
                    //                               Gap(10),
                    //                               SvgPicture.asset(
                    //                                 AppImage.calendar,
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //     );
                    //   },
                    // ),
                    // Gap(10),
                    // customGenderRadio(
                    //   genderIcon: '',
                    //   title: 'Miscarriage',

                    //   fillImage:
                    //       selectedCategory == 4
                    //           ? AppImage.fillCircle
                    //           : AppImage.circle,
                    //   buttonImage:
                    //       selectedCategory == 4
                    //           ? AppImage.colorCircle
                    //           : AppImage.circle,
                    //   onTap: () {
                    //     categoryRadioCubit.selectCategory(4);
                    //   },
                    // ),
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
