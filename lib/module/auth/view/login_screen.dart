import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    passwordVisibilityCubit.init();
    return Scaffold(
      body: customLoginTheme(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppPage.forgotFlowScreen);
                    },
                    child: CustomText(text: 'Forgot password?', fontSize: 10),
                  ),
                ),
                Gap(20),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    authCubit.login(
                      context,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
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
                        stepperCubit.init();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppPage.authScreen,
                          (route) => false,
                        );
                      },
                      child: CustomText(
                        text: 'Sign up',
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
        ),
      ),
    );
  }
}
