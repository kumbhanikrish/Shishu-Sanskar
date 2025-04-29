import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/create_new_password_screen.dart';
import 'package:shishu_sanskar/module/auth/view/forgot_password_screen.dart';
import 'package:shishu_sanskar/module/auth/view/otp_verification_screen.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';

class ForgotFlowScreen extends StatelessWidget {
  const ForgotFlowScreen({super.key});
  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    stepperCubit.init();
    return Scaffold(
      body: customLoginTheme(
        child: BlocBuilder<StepperCubit, int>(
          builder: (context, currentStep) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: <Widget>[
                    currentStep == 0
                        ? ForgotPasswordScreen()
                        : currentStep == 1
                        ? OtpVerificationScreen(verifyState: false)
                        : currentStep == 2
                        ? CreateNewPasswordScreen()
                        : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
