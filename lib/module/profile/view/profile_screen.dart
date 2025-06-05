import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
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
  final dynamic argument;
  const ProfileScreen({super.key, required this.argument});

  @override
  Widget build(BuildContext context) {
    LoginModel loginModel = argument['loginModelValue'];
    final TextEditingController numberController = TextEditingController(
      text: loginModel.user.contactNumber,
    );
    final TextEditingController wpNumberController = TextEditingController(
      text: loginModel.user.whatsappNumber,
    );
    final TextEditingController firstNameController = TextEditingController(
      text: loginModel.user.firstName,
    );
    final TextEditingController middleNameController = TextEditingController(
      text: loginModel.user.middleName,
    );
    final TextEditingController lastNameController = TextEditingController(
      text: loginModel.user.lastName,
    );
    final TextEditingController emailController = TextEditingController(
      text: loginModel.user.email,
    );
    StoreNumberCubit storeNumberCubit = BlocProvider.of<StoreNumberCubit>(
      context,
    );
    StoreWpNumberCubit storeWpNumberCubit = BlocProvider.of<StoreWpNumberCubit>(
      context,
    );

    storeNumberCubit.init();
    storeWpNumberCubit.init();
    log('loginModel.user.gender ::${loginModel.user.gender}');
    log('loginModel.user.gender ::${loginModel.user.marital}');
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

    radioCubit.selectUserType(
      loginModel.user.gender == 'male' ? UserType.male : UserType.female,
    );

    maritalRadioCubit.selectMaritalType(
      loginModel.user.marital == 'married'
          ? MaritalType.married
          : MaritalType.single,
    );

    counterCubit = context.read<CounterCubit>();
    counterCubit.setInitialCount(loginModel.user.noOfKid);

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
                  padding: EdgeInsets.only(bottom: 5.h),

                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            child: Stack(
                              children: [
                                BlocBuilder<ProfileImageCubit, File?>(
                                  builder: (context, pickedImage) {
                                    return Container(
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
                                        child:
                                            pickedImage != null
                                                ? Image.file(
                                                  pickedImage,
                                                  fit: BoxFit.cover,
                                                )
                                                : loginModel
                                                    .user
                                                    .profileImage
                                                    .isNotEmpty
                                                ? Image.network(
                                                  loginModel.user.profileImage,
                                                  fit: BoxFit.cover,
                                                )
                                                : Image.asset(
                                                  AppImage.user,
                                                  fit: BoxFit.cover,
                                                ),
                                      ),
                                    );
                                  },
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
                                        context
                                            .read<ProfileImageCubit>()
                                            .pickImage();
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

                                  controller: firstNameController,
                                ),
                              ),
                              Gap(4),
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'Middle Name',
                                  text: 'middle Name',

                                  controller: middleNameController,
                                ),
                              ),
                              Gap(4),
                              Expanded(
                                child: CustomTextField(
                                  hintText: 'Last Name',
                                  text: 'Last Name',

                                  controller: lastNameController,
                                ),
                              ),
                            ],
                          ),
                          Gap(20),
                          CustomTextField(
                            text: 'Email',
                            hintText: 'Email',

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
                                    image:
                                        numberFlag == ''
                                            ? AppFlag.inn
                                            : numberFlag,
                                    controller: numberController,
                                    prefixOnTap: () {
                                      customCountryBottomSheet(
                                        context,
                                        whatsapp: false,
                                      );
                                    },
                                    code: numberCode == '' ? '+91' : numberCode,
                                  ),
                                ],
                              );
                            },
                          ),
                          Gap(20),
                          BlocBuilder<StoreWpNumberCubit, StoreWpNumberState>(
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
                                    code:
                                        wpNumberCode == ''
                                            ? '+91'
                                            : wpNumberCode,
                                    image:
                                        wpNumberFlag == ''
                                            ? AppFlag.inn
                                            : wpNumberFlag,
                                    controller: wpNumberController,
                                    prefixOnTap: () {
                                      customCountryBottomSheet(
                                        context,
                                        whatsapp: true,
                                      );
                                    },
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
                                      onTap: () {
                                        radioCubit.selectUserType(
                                          UserType.male,
                                        );
                                      },
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
                                      onTap: () {
                                        radioCubit.selectUserType(
                                          UserType.female,
                                        );
                                      },
                                      title: 'Female',
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
                                      onTap: () {
                                        maritalRadioCubit.selectMaritalType(
                                          MaritalType.single,
                                        );
                                      },
                                      title: 'Single',
                                    ),
                                  ),
                                  Gap(10),
                                  Expanded(
                                    child: customGenderRadio(
                                      fillImage:
                                          selectedType == MaritalType.married
                                              ? AppImage.fillCircle
                                              : AppImage.circle,
                                      buttonImage:
                                          selectedType == MaritalType.married
                                              ? AppImage.colorCircle
                                              : AppImage.circle,
                                      genderIcon: AppImage.female,
                                      onTap: () {
                                        maritalRadioCubit.selectMaritalType(
                                          MaritalType.married,
                                        );
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
                                      borderRadius: BorderRadius.circular(10),
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
                                          onTap: () {
                                            counterCubit.increment();
                                          },
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
                                          onTap: () {
                                            counterCubit.decrement();
                                          },
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
                          CustomButton(text: 'Save', onTap: () {}),
                        ],
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
