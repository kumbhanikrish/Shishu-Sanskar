import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final TextEditingController numberController = TextEditingController();
  final TextEditingController wpNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StoreNumberCubit storeNumberCubit = BlocProvider.of<StoreNumberCubit>(
      context,
    );
    StoreWpNumberCubit storeWpNumberCubit = BlocProvider.of<StoreWpNumberCubit>(
      context,
    );
    EditCubit editCubit = BlocProvider.of<EditCubit>(context);

    storeNumberCubit.init();
    storeWpNumberCubit.init();
    editCubit.init();

    String numberFlag = '';
    String numberCode = '';
    String wpNumberFlag = '';
    String wpNumberCode = '';
    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);
    CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);
    MaritalRadioCubit maritalRadioCubit = BlocProvider.of<MaritalRadioCubit>(
      context,
    );
    counterCubit.init();
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'My Profile',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),

                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BlocBuilder<EditCubit, bool>(
                        builder: (context, editState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 15.h,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColor.themePrimaryColor2,
                                          width: 2,
                                        ),
                                      ),

                                      child: ClipOval(
                                        child: Image.asset(
                                          AppImage.user,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.themePrimaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            editCubit.toggleVisibility();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                AppImage.edit,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(30),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: 'Full Name',
                                      text: 'Full Name',
                                      readOnly: editState ? true : false,
                                      controller: fullNameController,
                                    ),
                                  ),
                                  Gap(4),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: 'Middle Name',
                                      text: 'middle Name',
                                      readOnly: editState ? true : false,

                                      controller: middleNameController,
                                    ),
                                  ),
                                  Gap(4),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: 'Last Name',
                                      text: 'Last Name',
                                      readOnly: editState ? true : false,

                                      controller: lastNameController,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(20),
                              CustomTextField(
                                text: 'Email',
                                hintText: 'Email',
                                readOnly: editState ? true : false,

                                prefixImage: AppImage.email,
                                controller: emailController,
                              ),
                              Gap(20),

                              BlocBuilder<StoreNumberCubit, StoreNumberState>(
                                builder: (context, state) {
                                  if (state is StoreNumberLoaded) {
                                    numberFlag = state.flag;
                                    numberCode = state.code;
                                  }
                                  return Column(
                                    children: [
                                      customNumberAndVerifiedText(
                                        text: 'Contact number',
                                        verifiedText: 'Verified',
                                        color: AppColor.themeSecondaryColor,
                                        onTap: () {},
                                      ),
                                      Gap(10),
                                      CustomCountyTextfield(
                                        readOnly: editState ? true : false,

                                        image:
                                            numberFlag == ''
                                                ? AppFlag.inn
                                                : numberFlag,
                                        controller: numberController,
                                        prefixOnTap:
                                            editState
                                                ? () {
                                                  customCountryBottomSheet(
                                                    context,
                                                    whatsapp: false,
                                                  );
                                                }
                                                : () {},
                                        code:
                                            numberCode == ''
                                                ? '+91'
                                                : numberCode,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Gap(20),
                              BlocBuilder<
                                StoreWpNumberCubit,
                                StoreWpNumberState
                              >(
                                builder: (context, state) {
                                  if (state is StoreWpNumberLoaded) {
                                    wpNumberFlag = state.flag;
                                    wpNumberCode = state.code;
                                  }
                                  return Column(
                                    children: [
                                      customNumberAndVerifiedText(
                                        text: 'WhatsApp number',
                                        verifiedText: 'Verify',
                                        color: AppColor.themePrimaryColor,
                                        onTap: () {},
                                      ),
                                      Gap(10),
                                      CustomCountyTextfield(
                                        readOnly: editState ? true : false,

                                        code:
                                            wpNumberCode == ''
                                                ? '+91'
                                                : wpNumberCode,
                                        image:
                                            wpNumberFlag == ''
                                                ? AppFlag.inn
                                                : wpNumberFlag,
                                        controller: wpNumberController,
                                        prefixOnTap:
                                            editState
                                                ? () {
                                                  customCountryBottomSheet(
                                                    context,
                                                    whatsapp: true,
                                                  );
                                                }
                                                : () {},
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Gap(20),
                              CustomText(
                                text: 'Gender',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              Gap(10),
                              BlocBuilder<RadioCubit, UserType>(
                                builder: (context, selectedType) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: customGenderRadio(
                                          fillImage:
                                              selectedType == UserType.male
                                                  ? AppImage.fillCircle
                                                  : AppImage.circle,
                                          buttonImage:
                                              selectedType == UserType.male
                                                  ? AppImage.colorCircle
                                                  : AppImage.circle,
                                          genderIcon: AppImage.male,
                                          onTap:
                                              editState
                                                  ? () {
                                                    radioCubit.selectUserType(
                                                      UserType.male,
                                                    );
                                                  }
                                                  : () {},
                                          title: 'Male',
                                        ),
                                      ),
                                      Gap(10),
                                      Expanded(
                                        child: customGenderRadio(
                                          fillImage:
                                              selectedType == UserType.female
                                                  ? AppImage.fillCircle
                                                  : AppImage.circle,
                                          buttonImage:
                                              selectedType == UserType.female
                                                  ? AppImage.colorCircle
                                                  : AppImage.circle,
                                          genderIcon: AppImage.female,
                                          onTap:
                                              editState
                                                  ? () {
                                                    radioCubit.selectUserType(
                                                      UserType.female,
                                                    );
                                                  }
                                                  : () {},
                                          title: 'Male',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              Gap(20),
                              CustomText(
                                text: 'Marital Status',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              Gap(10),
                              BlocBuilder<MaritalRadioCubit, MaritalType>(
                                builder: (context, selectedType) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: customGenderRadio(
                                          fillImage:
                                              selectedType == MaritalType.single
                                                  ? AppImage.fillCircle
                                                  : AppImage.circle,
                                          buttonImage:
                                              selectedType == MaritalType.single
                                                  ? AppImage.colorCircle
                                                  : AppImage.circle,
                                          genderIcon: AppImage.male,
                                          onTap:
                                              editState
                                                  ? () {
                                                    maritalRadioCubit
                                                        .selectMaritalType(
                                                          MaritalType.single,
                                                        );
                                                  }
                                                  : () {},
                                          title: 'Single',
                                        ),
                                      ),
                                      Gap(10),
                                      Expanded(
                                        child: customGenderRadio(
                                          fillImage:
                                              selectedType ==
                                                      MaritalType.married
                                                  ? AppImage.fillCircle
                                                  : AppImage.circle,
                                          buttonImage:
                                              selectedType ==
                                                      MaritalType.married
                                                  ? AppImage.colorCircle
                                                  : AppImage.circle,
                                          genderIcon: AppImage.female,
                                          onTap:
                                              editState
                                                  ? () {
                                                    maritalRadioCubit
                                                        .selectMaritalType(
                                                          MaritalType.married,
                                                        );
                                                  }
                                                  : () {
                                                    log('dfsdfsd');
                                                  },
                                          title: 'Married',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              Gap(10),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CustomText(
                                      text: 'No of kids',
                                      fontSize: 12,
                                    ),
                                  ),
                                  BlocBuilder<CounterCubit, int>(
                                    builder: (context, count) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: AppColor.themePrimaryColor2,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(13),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap:
                                                  editState
                                                      ? () {
                                                        counterCubit
                                                            .increment();
                                                      }
                                                      : () {},
                                              child: SvgPicture.asset(
                                                AppImage.increment,
                                              ),
                                            ),
                                            Gap(17),
                                            CustomText(
                                              text: count.toString().padLeft(
                                                2,
                                                '0',
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            Gap(17),

                                            InkWell(
                                              onTap:
                                                  editState
                                                      ? () {
                                                        counterCubit
                                                            .decrement();
                                                      }
                                                      : () {},
                                              child: SvgPicture.asset(
                                                AppImage.decrement,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Gap(40),
                              editState
                                  ? CustomButton(text: 'Save', onTap: () {})
                                  : SizedBox(),

                              Gap(5.h),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
