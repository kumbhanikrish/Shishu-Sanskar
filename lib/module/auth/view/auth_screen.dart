import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/number_screen.dart';
import 'package:shishu_sanskar/module/auth/view/otp_verification_screen.dart';
import 'package:shishu_sanskar/module/auth/view/select_categories_screen.dart';
import 'package:shishu_sanskar/module/auth/view/sign_up_Screen.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController wpNumberController = TextEditingController();

  String numberFlag = '';
  String numberCode = '';
  String wpNumberFlag = '';
  String wpNumberCode = '';
  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    StoreNumberCubit storeNumberCubit = BlocProvider.of<StoreNumberCubit>(
      context,
    );
    StoreWpNumberCubit storeWpNumberCubit = BlocProvider.of<StoreWpNumberCubit>(
      context,
    );

    storeNumberCubit.init();
    storeWpNumberCubit.init();

    // stepperCubit.init();

    Widget getStepText(int step) {
      switch (step) {
        case 0:
          return SignUpScreen(
            fullNameController: fullNameController,
            emailController: emailController,
            cPasswordController: cPasswordController,
            passwordController: passwordController,
            onTap: () {
              stepperCubit.nextStep(step: 1);
            },
          );
        case 1:
          return BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, verifyState) {
              return verifyState == false
                  ? OtpVerificationScreen(verifyState: verifyState)
                  : BlocBuilder<StoreNumberCubit, StoreNumberState>(
                    builder: (context, state) {
                      if (state is StoreNumberLoaded) {
                        numberFlag = state.flag;
                        numberCode = state.code;
                      }
                      return BlocBuilder<
                        StoreWpNumberCubit,
                        StoreWpNumberState
                      >(
                        builder: (context, state) {
                          if (state is StoreWpNumberLoaded) {
                            wpNumberFlag = state.flag;
                            wpNumberCode = state.code;
                          }
                          return NumberScreen(
                            verifyOnTap: () {
                              passwordVisibilityCubit.toggleVisibility();
                            },
                            onTap: () {
                              stepperCubit.nextStep(step: 2);
                            },
                            backOnTap: () {
                              stepperCubit.previousStep(step: 0);
                            },
                            numberController: numberController,
                            wpNumberController: wpNumberController,
                            numberText: 'Verified',
                            wpNumberText: 'Verify',
                            wpNumberColor: AppColor.themePrimaryColor,
                            numberColor: AppColor.themeSecondaryColor,
                            numberPrefixOnTap: () {
                              customCountryBottomSheet(
                                context,
                                whatsapp: false,
                              );
                            },
                            wpNumberPrefixOnTap: () {
                              customCountryBottomSheet(context, whatsapp: true);
                            },
                            numberFlag:
                                numberFlag == '' ? AppFlag.inn : numberFlag,
                            wpNumberFlag:
                                wpNumberFlag == '' ? AppFlag.inn : wpNumberFlag,

                            numberCode: numberCode == '' ? '+91' : numberCode,
                            wpNumberCode:
                                wpNumberCode == '' ? '+91' : wpNumberCode,
                          );
                        },
                      );
                    },
                  );
            },
          );
        case 2:
          return SelectCategoriesScreen(
            onTap: () {},
            backOnTap: () {
              stepperCubit.nextStep(step: 1);
            },
          );
        default:
          return Container();
      }
    }

    return Scaffold(
      body: customLoginTheme(
        child: BlocBuilder<StepperCubit, int>(
          builder: (context, currentStep) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Gap(3.6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => buildStep(index, currentStep, 3),
                    ),
                  ),

                  Gap(3.6.h),

                  getStepText(currentStep),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
