import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController cPasswordController;
  final bool isGoogle;
  final Function() onTap;
  const SignUpScreen({
    super.key,
    required this.firstNameController,
    required this.emailController,
    required this.cPasswordController,
    required this.passwordController,
    required this.middleNameController,
    required this.lastNameController,
    required this.onTap,
    required this.isGoogle,
  });
  @override
  Widget build(BuildContext context) {
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    CPasswordVisibilityCubit cPasswordVisibilityCubit =
        BlocProvider.of<CPasswordVisibilityCubit>(context);
    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );
    passwordVisibilityCubit.init();
    cPasswordVisibilityCubit.init();
    categoryRadioCubit.init();

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
              text: 'First Name',
              hintText: 'First Name',
              prefixImage: AppImage.fullName,
              controller: firstNameController,
            ),
            Gap(10),
            CustomTextField(
              text: 'Middle Name',
              hintText: 'Middle Name',
              prefixImage: AppImage.fullName,
              controller: middleNameController,
            ),
            Gap(10),
            CustomTextField(
              text: 'Last Name',
              hintText: 'Last Name',
              prefixImage: AppImage.fullName,
              controller: lastNameController,
            ),
            Gap(10),
            CustomTextField(
              text: 'Email',
              hintText: 'Email',
              prefixImage: AppImage.email,
              controller: emailController,
            ),
            Gap(10),

            if (!isGoogle) ...[
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
            ],

            Gap(20),
            CustomButton(text: 'Continue', onTap: onTap),
            Gap(20),
            customSocialMediaLogin(context),

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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
