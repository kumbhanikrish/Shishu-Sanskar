// import 'package:country_code_picker/country_code_picker.dart';

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shishu_sanskar/local_data/local_data_sever.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/module/blog/cubit/blog_cubit.dart';
import 'package:shishu_sanskar/module/graph/cubit/graph_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/task/task_cubit.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
import 'package:shishu_sanskar/module/tools/cubit/chinese_gender_predictor/chinese_gender_predictor_cubit.dart';
import 'package:shishu_sanskar/module/tools/cubit/due_date_calculator/due_date_cubit.dart';
import 'package:shishu_sanskar/module/tools/cubit/ovulation_calculator/cubit/ovulation_calculator_cubit.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/routes/app_routes.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:sizer/sizer.dart';

void configLoading() {
  EasyLoading.instance
    ..backgroundColor = AppColor.themeSecondaryColor
    ..indicatorColor = AppColor.lightThemePrimaryColor
    ..textColor = AppColor.lightThemePrimaryColor
    ..progressColor = AppColor.lightThemePrimaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..loadingStyle = EasyLoadingStyle.custom
    ..dismissOnTap = false;
}

Future<LoginModel> loginData() async {
  LoginModel loginModel = await localDataSaver.getLoginModel();
  return loginModel;
}

Future<int> planId() async {
  int planId = await localDataSaver.getPlanId();
  return planId;
}

Future<String> lmpDate() async {
  String lmpDate = await localDataSaver.getLmpDate();
  return lmpDate;
}

Future<String> categoryName() async {
  String lmpDate = await localDataSaver.getCategoryName();
  return lmpDate;
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

ApiServices api = ApiServices();

LocalDataSaver localDataSaver = LocalDataSaver();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling background message: ${message.messageId}");
  showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  log('🔔 Notification permission status: ${settings.authorizationStatus}');

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
  configLoading();
}

void showNotification(RemoteMessage message) async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);

  final androidDetails = AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  final platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? message.data['title'] ?? 'No Title',
    message.notification?.body ?? message.data['body'] ?? 'No Body',
    platformDetails,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      bool notificationsEnabled =
          await localDataSaver.getNotificationsEnabled();
      log('📲 Foreground message received $notificationsEnabled');

      if (notificationsEnabled == true) {
        log('📢 Notifications enabled, displaying notification');
        showNotification(message);
      }
    });

    void handleMessageNavigation(RemoteMessage message) {
      final screen = message.data['screen'];
      log('🔁 Navigating to screen from notification: $screen');

      if (screen == 'offers') {
        navigatorKey.currentState?.pushNamed('/offersScreen');
      } else if (screen == 'profile') {
        navigatorKey.currentState?.pushNamed('/profileScreen');
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🟢 App opened from background notification');
      handleMessageNavigation(message);
    });

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: providers,
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              dialogTheme: DialogTheme(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
                iconTheme: IconThemeData(color: AppColor.greyColor),
              ),
              bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
              ),
              scaffoldBackgroundColor: AppColor.whiteColor,
              bottomAppBarTheme: BottomAppBarTheme(
                color: AppColor.whiteColor,
                surfaceTintColor: AppColor.whiteColor,
              ),
            ),
            routes: appRoutes,
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}

dynamic providers = [
  BlocProvider(create: (context) => AuthCubit()),
  BlocProvider(create: (context) => StepperCubit()),
  BlocProvider(create: (context) => PasswordVisibilityCubit()),
  BlocProvider(create: (context) => CPasswordVisibilityCubit()),
  BlocProvider(create: (context) => RadioCubit()),
  BlocProvider(create: (context) => StoreNumberCubit()),
  BlocProvider(create: (context) => StoreWpNumberCubit()),
  BlocProvider(create: (context) => CategoryRadioCubit()),
  BlocProvider(create: (context) => BottomBarCubit()),
  BlocProvider(create: (context) => MaritalRadioCubit()),
  BlocProvider(create: (context) => CounterCubit()),
  BlocProvider(create: (context) => ProfileCubit()),
  BlocProvider(create: (context) => LmpCubit()),
  BlocProvider(create: (context) => VerifiedNumber()),
  BlocProvider(create: (context) => VerifiedWNumber()),
  BlocProvider(create: (context) => ReasonCubit()),
  BlocProvider(create: (context) => ProfileImageCubit()),
  BlocProvider(create: (context) => BlogCubit()),
  BlocProvider(create: (context) => PricingCubit()),
  BlocProvider(create: (context) => DatePickerCubit()),
  BlocProvider(create: (context) => DatePicker2Cubit()),
  BlocProvider(create: (context) => OvulationCalculatorCubit()),
  BlocProvider(create: (context) => SelectCalenderCubit()),
  BlocProvider(create: (context) => SelectCycleCubit()),
  BlocProvider(create: (context) => DueDateCubit()),
  BlocProvider(create: (context) => ChineseGenderPredictorCubit()),
  BlocProvider(create: (context) => GraphTabCubit()),
  BlocProvider(create: (context) => EventCubit()),
  BlocProvider(create: (context) => TaskCubit()),
  BlocProvider(create: (context) => GraphCubit()),
  BlocProvider(create: (context) => LanguagesRadioCubit()),
  BlocProvider(create: (context) => SelectedDateCubit()),
];
