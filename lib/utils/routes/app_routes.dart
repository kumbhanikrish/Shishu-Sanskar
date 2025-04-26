import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/auth/view/auth_screen.dart';
import 'package:shishu_sanskar/module/auth/view/create_new_password_screen.dart';
import 'package:shishu_sanskar/module/auth/view/forgot_password_Screen.dart';
import 'package:shishu_sanskar/module/auth/view/login_screen.dart';
import 'package:shishu_sanskar/module/auth/view/otp_verification_screen.dart';
import 'package:shishu_sanskar/module/auth/view/splash_screen.dart';

import 'package:shishu_sanskar/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),
  AppPage.loginScreen: (context) => LoginScreen(),
  AppPage.authScreen: (context) => const AuthScreen(),
  AppPage.forgotPasswordScreen: (context) => ForgotPasswordScreen(),
  AppPage.otpVerificationScreen: (context) => OtpVerificationScreen(),
  AppPage.createNewPasswordScreen: (context) => CreateNewPasswordScreen(),

  // AppRoutes.referAndEarnScreen:
  //     (context) =>
  //         ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
};
