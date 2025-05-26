// import 'package:country_code_picker/country_code_picker.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shishu_sanskar/local_data/local_data_sever.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

ApiServices api = ApiServices();

LocalDataSaver localDataSaver = LocalDataSaver();

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
  BlocProvider(create: (context) => EditCubit()),
  BlocProvider(create: (context) => VerifiedNumber()),
  BlocProvider(create: (context) => VerifiedWNumber()),
];
