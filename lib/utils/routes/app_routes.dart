import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/auth/view/auth_screen.dart';
import 'package:shishu_sanskar/module/auth/view/forgot_flow_screen.dart';
import 'package:shishu_sanskar/module/auth/view/login_screen.dart';
import 'package:shishu_sanskar/module/auth/view/splash_screen.dart';
import 'package:shishu_sanskar/module/blog/view/blog_detail_screen.dart';
import 'package:shishu_sanskar/module/home/view/bottom_navigation_screen.dart';
import 'package:shishu_sanskar/module/home/view/event_detail_screen.dart';
import 'package:shishu_sanskar/module/home/view/event_see_all_screen.dart';
import 'package:shishu_sanskar/module/home/view/task_detail_Screen.dart';
import 'package:shishu_sanskar/module/home/view/task_see_all_screen.dart';
import 'package:shishu_sanskar/module/pricing/view/pay_detail_Screen.dart';
import 'package:shishu_sanskar/module/profile/view/profile_screen.dart';
import 'package:shishu_sanskar/module/setting/view/contact_us_screen.dart';
import 'package:shishu_sanskar/module/setting/view/delete_account_screen.dart';
import 'package:shishu_sanskar/module/setting/view/delete_password_screen.dart';
import 'package:shishu_sanskar/module/setting/view/privacy_police_screen.dart';
import 'package:shishu_sanskar/module/setting/view/setting_screen.dart';

import 'package:shishu_sanskar/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),
  AppPage.loginScreen: (context) => LoginScreen(),
  AppPage.authScreen: (context) => const AuthScreen(),
  AppPage.forgotFlowScreen: (context) => ForgotFlowScreen(),
  AppPage.bottomNavigationScreen: (context) => BottomNavigationScreen(),
  AppPage.taskSeeAllScreen: (context) => TaskSeeAllScreen(),
  AppPage.taskDetailScreen: (context) => TaskDetailScreen(),
  AppPage.eventSeeAllScreen: (context) => EventSeeAllScreen(),
  AppPage.eventDetailScreen: (context) => EventDetailScreen(),
  AppPage.settingScreen: (context) => SettingScreen(),
  AppPage.profileScreen: (context) => ProfileScreen(),
  AppPage.contactUsScreen: (context) => ContactUsScreen(),

  AppPage.privacyPolicyScreen: (context) => const PrivacyPoliceScreen(),
  AppPage.deleteAccountScreen: (context) => DeleteAccountScreen(),
  AppPage.deletePasswordScreen: (context) => DeletePasswordScreen(),
  AppPage.blogDetailScreen: (context) => BlogDetailScreen(),
  AppPage.payDetailScreen: (context) => PayDetailScreen(),

  // AppRoutes.referAndEarnScreen:
  //     (context) =>
  //         ReferAndEarnScreen(data: ModalRoute.of(context)?.settings.arguments),
};
