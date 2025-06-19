import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class OtpVerificationScreen extends StatelessWidget {
  final bool verifyState;
  final String number;
  final String wNumber;
  final bool forgotOtp;

  OtpVerificationScreen({
    super.key,
    required this.verifyState,
    required this.number,
    required this.wNumber,
    required this.forgotOtp,
  });
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
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    VerifiedNumber verifiedNumber = BlocProvider.of<VerifiedNumber>(context);
    VerifiedWNumber verifiedWNumber = BlocProvider.of<VerifiedWNumber>(context);

    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
              text: 'OTP Verification',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text:
                  'Send to ${forgotOtp == true ? number : '+91 ${number.isEmpty ? wNumber : number}'}',
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
              onPressed: () {
                if (forgotOtp == true) {
                  authCubit.forgotPassword(
                    context,
                    email: number,
                    resend: true,
                    stepperCubit: stepperCubit,
                  );
                } else {
                  authCubit.sendOtp(
                    context,
                    mobile: wNumber.isEmpty ? number : wNumber,
                    passwordVisibilityCubit: passwordVisibilityCubit,
                  );
                }
              },
              color: AppColor.themeSecondaryColor,
            ),
            Gap(10.h),

            BlocBuilder<VerifiedWNumber, bool>(
              builder: (context, wNumberState) {
                return BlocBuilder<VerifiedNumber, bool>(
                  builder: (context, numberState) {
                    return CustomButton(
                      text: 'Verify',
                      onTap:
                          forgotOtp == true
                              ? () {
                                authCubit.forgotOtpVerify(
                                  context,
                                  email: number,
                                  otp: pinController.text.trim(),
                                  stepperCubit: stepperCubit,
                                );
                              }
                              : () {
                                authCubit.verifyOtp(
                                  context,
                                  opt: pinController.text.trim(),
                                  mobile: wNumber.isEmpty ? number : wNumber,
                                  passwordVisibilityCubit:
                                      passwordVisibilityCubit,
                                  verifiedNumber: verifiedNumber,
                                  verifiedWNumber: verifiedWNumber,
                                  number: numberState,
                                  wNumber: wNumberState,
                                );
                              },
                    );
                  },
                );
              },
            ),
            Gap(10),

            CustomTextButton(
              text: 'Cancel',
              onPressed: () {
                if (forgotOtp == true) {
                  stepperCubit.previousStep(step: 0);
                } else {
                  passwordVisibilityCubit.toggleVisibility();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
