import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/number_screen.dart';
import 'package:shishu_sanskar/module/auth/view/otp_verification_screen.dart';
import 'package:shishu_sanskar/module/auth/view/select_categories_screen.dart';
import 'package:shishu_sanskar/module/auth/view/sign_up_Screen.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  final dynamic arguments;
  const AuthScreen({super.key, this.arguments});

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
  String numberCode = '+91';
  String wpNumberFlag = '';
  String wpNumberCode = '+91';

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // Open app settings if permission is permanently denied
      await Geolocator.openAppSettings();
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Open location settings if location is off
      await Geolocator.openLocationSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isGoogle =
        widget.arguments != null ? widget.arguments['google'] : false;

    String email = widget.arguments != null ? widget.arguments['email'] : '';
    String googleToken =
        widget.arguments != null ? widget.arguments['google_token'] : '';
    String firstName =
        widget.arguments != null ? widget.arguments['firstName'] : '';
    String middleName =
        widget.arguments != null ? widget.arguments['middleName'] : '';
    String lastName =
        widget.arguments != null ? widget.arguments['lastName'] : '';

    if (email.isNotEmpty) {
      emailController.text = email;
      firstNameController.text = firstName;
      middleNameController.text = middleName;
      lastNameController.text = lastName;
    }

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

    // if (isGoogle) {
    //   authCubit.handleGoogleSignOut(context);
    // }
    stepperCubit.init();

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
            isGoogle: isGoogle,
            onTap: () {
              final firstName = firstNameController.text.trim();
              final lastName = lastNameController.text.trim();
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              final confirmPassword = cPasswordController.text.trim();

              if (firstName.isEmpty) {
                customErrorToast(context, text: 'Please enter your first name');
                return;
              }

              // middleName optional, no validation unless needed

              if (lastName.isEmpty) {
                customErrorToast(context, text: 'Please enter your last name');
                return;
              }

              if (email.isEmpty) {
                customErrorToast(context, text: 'Please enter your email');
                return;
              }

              final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegex.hasMatch(email)) {
                customErrorToast(
                  context,
                  text: 'Please enter a valid email address',
                );
                return;
              }

              if (password.isEmpty && !isGoogle) {
                customErrorToast(context, text: 'Please enter your password');
                return;
              }

              if (password.length < 8 && !isGoogle) {
                customErrorToast(
                  context,
                  text: 'Password must be at least 8 characters',
                );
                return;
              }

              if (confirmPassword.isEmpty && !isGoogle) {
                customErrorToast(context, text: 'Please confirm your password');
                return;
              }

              if (password != confirmPassword && !isGoogle) {
                customErrorToast(context, text: 'Passwords do not match');
                return;
              }
              stepperCubit.nextStep(step: 1);
              passwordVisibilityCubit.init();
            },
          );
        case 1:
          return BlocBuilder<PasswordVisibilityCubit, bool>(
            builder: (context, verifyState) {
              return verifyState == false
                  ? OtpVerificationScreen(
                    forgotOtp: false,
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
                          return BlocBuilder<VerifiedWNumber, bool>(
                            builder: (context, wNumberState) {
                              return BlocBuilder<VerifiedNumber, bool>(
                                builder: (context, verifiedNumber) {
                                  return NumberScreen(
                                    onTap: () {
                                      final number =
                                          numberController.text.trim();
                                      final wpNumber =
                                          wpNumberController.text.trim();
                                      if (number.isEmpty) {
                                        customErrorToast(
                                          context,
                                          text: 'Please enter your number',
                                        );

                                        return;
                                      }

                                      log('numberCodenumberCode ::$numberCode');

                                      if (!verifiedNumber) {
                                        customErrorToast(
                                          context,
                                          text: 'Verify your contact number',
                                        );

                                        return;
                                      }
                                      if (wpNumberCode == '+91') {
                                        if (wpNumber.isEmpty) {
                                          customErrorToast(
                                            context,
                                            text:
                                                'Please enter your whatsapp number',
                                          );
                                          return;
                                        }

                                        if (!wNumberState) {
                                          customErrorToast(
                                            context,
                                            text: 'Verify your whatsapp number',
                                          );
                                          return;
                                        }
                                      }
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
                                      customCountryBottomSheet(
                                        context,
                                        whatsapp: true,
                                      );
                                    },
                                    numberFlag:
                                        numberFlag == ''
                                            ? AppFlag.inn
                                            : numberFlag,
                                    wpNumberFlag:
                                        wpNumberFlag == ''
                                            ? AppFlag.inn
                                            : wpNumberFlag,

                                    numberCode:
                                        numberCode == '' ? '+91' : numberCode,
                                    wpNumberCode:
                                        wpNumberCode == ''
                                            ? '+91'
                                            : wpNumberCode,
                                  );
                                },
                              );
                            },
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
                  return BlocBuilder<DatePickerCubit, DateTime?>(
                    builder: (context, selectDate) {
                      return SelectCategoriesScreen(
                        onTap: () {
                          if (selectedCategory == 0) {
                            customErrorToast(
                              context,
                              text: 'Please select categories',
                            );

                            return;
                          }
                          if ((selectedCategory == 2 ||
                                  selectedCategory == 3) &&
                              selectDate == null) {
                            customErrorToast(
                              context,
                              text: 'Please select LMP date',
                            );

                            return;
                          }
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

                            passwordConfirmation:
                                cPasswordController.text.trim(),
                            gender:
                                selectedType == UserType.male
                                    ? 'male'
                                    : 'female',
                            lmp:
                                selectedCategory == 2 || selectedCategory == 3
                                    ? DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(selectDate ?? DateTime.now())
                                    : '',
                            googleToken: googleToken ?? '',
                            appleToken: '',
                          );
                        },
                        backOnTap: () {
                          stepperCubit.nextStep(step: 1);
                        },
                      );
                    },
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
