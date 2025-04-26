import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cPasswordController;
  final Function() onTap;
  const SignUpScreen({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.cPasswordController,
    required this.passwordController,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    CPasswordVisibilityCubit cPasswordVisibilityCubit =
        BlocProvider.of<CPasswordVisibilityCubit>(context);
    passwordVisibilityCubit.init();
    cPasswordVisibilityCubit.init();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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

            CustomTextField(
              text: 'Full Name',
              hintText: 'Full Name',
              prefixImage: AppImage.fullName,
              controller: fullNameController,
            ),
            Gap(10),
            CustomTextField(
              text: 'Email',
              hintText: 'Email',
              prefixImage: AppImage.email,
              controller: emailController,
            ),
            Gap(10),
            BlocBuilder<PasswordVisibilityCubit, bool>(
              builder: (context, isHidden) {
                return CustomTextField(
                  text: 'Password',
                  obscureText: isHidden,

                  hintText: 'Password',
                  prefixImage: AppImage.lock,
                  controller: passwordController,
                  suffixIcon: customPrefixIcon(
                    onTap: () {
                      passwordVisibilityCubit.toggleVisibility();
                    },
                    image: isHidden ? AppImage.eyeSlash : AppImage.eye,
                  ),
                );
              },
            ),
            Gap(10),

            BlocBuilder<CPasswordVisibilityCubit, bool>(
              builder: (context, isHidden) {
                return CustomTextField(
                  text: 'Confirm Password',
                  obscureText: isHidden,

                  hintText: 'Confirm Password',
                  prefixImage: AppImage.lock,
                  controller: cPasswordController,
                  suffixIcon: customPrefixIcon(
                    onTap: () {
                      cPasswordVisibilityCubit.toggleVisibility();
                    },
                    image: isHidden ? AppImage.eyeSlash : AppImage.eye,
                  ),
                );
              },
            ),

            Gap(20),
            CustomButton(
              text: 'Continue',
              onTap: onTap,
              backgroundColor: AppColor.themePrimaryColor2,
            ),
            Gap(20),
            customSocialMediaLogin(googleOnTap: () {}, appleOnTap: () {}),

            Gap(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Already have an account? ', fontSize: 10),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppPage.loginScreen,
                      (route) => false,
                    );
                  },
                  child: CustomText(
                    text: 'Sign in',
                    fontSize: 10,
                    color: AppColor.themePrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOrDivider() {
  return Row(
    children: [
      Expanded(child: Divider(thickness: 1, color: AppColor.dividerColor)),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomText(
          text: 'Or Sign Up With',
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(child: Divider(thickness: 1, color: AppColor.dividerColor)),
    ],
  );
}

customSocialMediaLogin({
  required void Function() googleOnTap,
  required void Function() appleOnTap,
}) {
  return Column(
    children: <Widget>[
      buildOrDivider(),
      Gap(20),

      Row(
        children: <Widget>[
          Expanded(
            child: CustomIconTextButton(
              text: 'Google',
              onTap: googleOnTap,
              image: AppImage.google,
            ),
          ),
          Gap(10),
          Expanded(
            child: CustomIconTextButton(
              text: 'Apple',
              onTap: appleOnTap,
              image: AppImage.apple,
            ),
          ),
        ],
      ),
    ],
  );
}
