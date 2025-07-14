import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class NumberScreen extends StatelessWidget {
  final void Function() onTap;
  final void Function() backOnTap;

  final TextEditingController numberController;
  final TextEditingController wpNumberController;

  final String numberFlag;
  final String numberCode;
  final String wpNumberFlag;
  final String wpNumberCode;

  final void Function() numberPrefixOnTap;
  final void Function() wpNumberPrefixOnTap;
  const NumberScreen({
    super.key,
    required this.onTap,
    required this.backOnTap,
    required this.numberController,
    required this.wpNumberController,

    required this.numberPrefixOnTap,
    required this.wpNumberPrefixOnTap,
    required this.numberFlag,
    required this.wpNumberFlag,
    required this.numberCode,
    required this.wpNumberCode,
  });
  @override
  Widget build(BuildContext context) {
    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
              text: 'Sign up',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text: 'Sign up to Create your account',
              fontSize: 12,
              color: AppColor.subTitleColor,
            ),
            Gap(3.6.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                              radioCubit.selectUserType(UserType.male);
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
                              radioCubit.selectUserType(UserType.female);
                            },
                            title: 'Female',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gap(10),
                // BlocBuilder<VerifiedNumber, bool>(
                //   builder: (context, verifiedNumber) {
                //     return customNumberAndVerifiedText(
                //       text: 'Contact number',
                //       verifiedText: verifiedNumber ? 'Verified' : 'Verify',
                //       color:
                //           verifiedNumber
                //               ? AppColor.themeSecondaryColor
                //               : AppColor.themePrimaryColor,
                //       onTap:
                //           verifiedNumber
                //               ? () {}
                //               : () {
                //                 authCubit.sendOtp(
                //                   context,
                //                   mobile: numberController.text.trim(),
                //                   passwordVisibilityCubit:
                //                       passwordVisibilityCubit,
                //                 );
                //               },
                //     );
                //   },
                // ),
                // Gap(10),
                CustomCountyTextfield(
                  image: numberFlag,
                  controller: numberController,
                  prefixOnTap: numberPrefixOnTap,
                  code: numberCode,
                ),

                Gap(10),

                // BlocBuilder<VerifiedWNumber, bool>(
                //   builder: (context, wNumberState) {
                //     return customNumberAndVerifiedText(
                //       text: 'WhatsApp number',
                //       verifiedText:
                //           wpNumberCode == '+91'
                //               ? wNumberState
                //                   ? 'Verified'
                //                   : 'Verify'
                //               : '',
                //       color:
                //           wNumberState
                //               ? AppColor.themeSecondaryColor
                //               : AppColor.themePrimaryColor,
                //       onTap: () {
                        // authCubit.sendOtp(
                        //   context,
                        //   mobile: wpNumberController.text.trim(),
                        //   passwordVisibilityCubit: passwordVisibilityCubit,
                        // );
                //       },
                //     );
                //   },
                // ),
                CustomCountyTextfield(
                  code: wpNumberCode,
                  image: wpNumberFlag,
                  controller: wpNumberController,
                  prefixOnTap: wpNumberPrefixOnTap,
                ),

                Gap(20),
                CustomButton(text: 'Continue', onTap: onTap),

                Align(
                  child: CustomTextButton(text: 'Back', onPressed: backOnTap),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
