import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customLoginTheme(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: <Widget>[
                CustomText(
                  text: 'Forgot Password',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                Gap(3.6.h),

                CustomTextField(
                  text: 'Email',
                  hintText: 'Email',
                  prefixImage: AppImage.email,
                  controller: emailController,
                ),
                Gap(10.h),
                CustomButton(
                  text: 'Next',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppPage.otpVerificationScreen,
                      (route) => false,
                    );
                  },
                ),
                Gap(10),
                CustomTextButton(
                  text: 'Back',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppPage.loginScreen,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
