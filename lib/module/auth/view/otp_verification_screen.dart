import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
  final defaultPinTheme = PinTheme(
    width: 42,
    height: 40,
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColor.themePrimaryColor,
      fontWeight: FontWeight.w500,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.themePrimaryColor2),
      borderRadius: BorderRadius.circular(12),
    ),
  );
  TextEditingController pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customLoginTheme(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

            child: Column(
              children: [
                CustomText(
                  text: 'OTP Verification',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                Gap(5),
                CustomText(
                  text: 'Send to +91 81550 75910',
                  fontSize: 12,
                  color: AppColor.subTitleColor,
                ),
                Gap(3.6.h),
                Center(
                  child: Pinput(
                    controller: pinController,
                    length: 4,
                    animationCurve: Curves.easeInOut,
                    defaultPinTheme: defaultPinTheme,
                  ),
                ),

                CustomTextButton(
                  text: 'Didn’t get a code?',
                  onPressed: () {},
                  color: AppColor.themeSecondaryColor,
                ),
                Gap(10.h),

                CustomButton(
                  text: 'Verify',
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppPage.createNewPasswordScreen,
                      (route) => false,
                    );
                  },
                ),
                Gap(10),

                CustomTextButton(text: 'Cancel', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
