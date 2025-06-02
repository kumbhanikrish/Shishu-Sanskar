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
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController wpNumberController = TextEditingController();

  String numberFlag = '';
  String numberCode = '';
  String wpNumberFlag = '';
  String wpNumberCode = '';
 
  final ValueNotifier<String> planningCoupleDate = ValueNotifier<String>(
    'dd/mm/yyyy',
  );
  final ValueNotifier<String> pregnantMotherDate = ValueNotifier<String>(
    'dd/mm/yyyy',
  );

  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

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
            firstNameController: firstNameController,
            emailController: emailController,
            cPasswordController: cPasswordController,
            passwordController: passwordController,
            middleNameController: middleNameController,
            lastNameController: lastNameController,

            onTap: () {
              stepperCubit.nextStep(step: 1);
              passwordVisibilityCubit.init();
            },
          );
        case 1:
          return BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, verifyState) {
              return verifyState == false
                  ? OtpVerificationScreen(
                    verifyState: verifyState,
                    number: numberController.text.trim(),
                    wNumber: wpNumberController.text.trim(),
                  )
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
                            onTap: () {
                              stepperCubit.nextStep(step: 2);
                            },
                            backOnTap: () {
                              stepperCubit.previousStep(step: 0);
                            },
                            numberController: numberController,
                            wpNumberController: wpNumberController,

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
          return BlocBuilder<RadioCubit, UserType>(
            builder: (context, selectedType) {
              return BlocBuilder<CategoryRadioCubit, int>(
                builder: (context, selectedCategory) {
                  return SelectCategoriesScreen(
                    onTap: () {
                      authCubit.register(
                        context,
                        firstName: firstNameController.text.trim(),
                        middleName: middleNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        contactNumber: numberController.text.trim(),
                        whatsappNumber: wpNumberController.text.trim(),
                        categoryId: selectedCategory,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        passwordConfirmation: cPasswordController.text.trim(),
                        gender:
                            selectedType == UserType.male ? 'male' : 'female',
                        lmp:
                            selectedCategory == 2
                                ? planningCoupleDate.value
                                : pregnantMotherDate.value,
                      );
                    },
                    backOnTap: () {
                      stepperCubit.nextStep(step: 1);
                    },
                    planningCoupleDate: planningCoupleDate,
                    pregnantMotherDate: pregnantMotherDate,
                  );
                },
              );
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
