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
import 'package:shishu_sanskar/module/home/view/task_detail_image_preview_screen.dart';
import 'package:shishu_sanskar/module/home/view/task_see_all_screen.dart';
import 'package:shishu_sanskar/module/pricing/view/pay_detail_Screen.dart';
import 'package:shishu_sanskar/module/profile/view/edit_profile_screen.dart';
import 'package:shishu_sanskar/module/setting/view/contact_us_screen.dart';
import 'package:shishu_sanskar/module/setting/view/delete_account_screen.dart';
import 'package:shishu_sanskar/module/setting/view/delete_password_screen.dart';
import 'package:shishu_sanskar/module/setting/view/languages_screen.dart';
import 'package:shishu_sanskar/module/setting/view/plan_history_screen.dart';
import 'package:shishu_sanskar/module/setting/view/privacy_police_screen.dart';
import 'package:shishu_sanskar/module/setting/view/setting_screen.dart';
import 'package:shishu_sanskar/module/setting/view/user_event_screen.dart';
import 'package:shishu_sanskar/module/tools/view/chinese_gender_predictor/chinese_gender_predictor_screen.dart';
import 'package:shishu_sanskar/module/tools/view/due_date/due_date_screen.dart';
import 'package:shishu_sanskar/module/tools/view/ovulation/ovulation_calculator_screen.dart';

import 'package:shishu_sanskar/utils/constant/app_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppPage.splashScreen: (context) => const SplashScreen(),
  AppPage.loginScreen: (context) => LoginScreen(),
  AppPage.authScreen:
      (context) =>
          AuthScreen(arguments: ModalRoute.of(context)?.settings.arguments),
  AppPage.forgotFlowScreen: (context) => ForgotFlowScreen(),
  AppPage.bottomNavigationScreen: (context) => BottomNavigationScreen(),
  AppPage.taskSeeAllScreen:
      (context) =>
          TaskSeeAllScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.taskDetailScreen:
      (context) =>
          TaskDetailScreen(data: ModalRoute.of(context)?.settings.arguments),
  AppPage.eventSeeAllScreen: (context) => EventSeeAllScreen(),
  AppPage.eventDetailScreen:
      (context) => EventDetailScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.settingScreen: (context) => SettingScreen(),
  AppPage.editProfileScreen:
      (context) => EditProfileScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.contactUsScreen: (context) => ContactUsScreen(),

  AppPage.privacyPolicyScreen: (context) => const PrivacyPolicyScreen(),
  AppPage.deleteAccountScreen: (context) => DeleteAccountScreen(),
  AppPage.deletePasswordScreen:
      (context) => DeletePasswordScreen(
        arguments: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.blogDetailScreen:
      (context) => BlogDetailScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),
  AppPage.payDetailScreen:
      (context) =>
          PayDetailScreen(argument: ModalRoute.of(context)?.settings.arguments),
  AppPage.chineseGenderPredictorScreen:
      (context) => ChineseGenderPredictorScreen(),
  AppPage.dueDateScreen: (context) => DueDateScreen(),
  AppPage.ovulationCalculatorScreen: (context) => OvulationCalculatorScreen(),
  AppPage.userEventScreen: (context) => UserEventScreen(),
  AppPage.planHistoryScreen: (context) => PlanHistoryScreen(),
  AppPage.languagesScreen: (context) => LanguagesScreen(),
  AppPage.taskDetailImagePreviewScreen:
      (context) => TaskDetailImagePreviewScreen(
        argument: ModalRoute.of(context)?.settings.arguments,
      ),
};
