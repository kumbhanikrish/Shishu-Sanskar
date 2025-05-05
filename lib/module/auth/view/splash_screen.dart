import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () async {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.loginScreen,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.splashBGImage),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(child: Image.asset(AppLogo.splashLogo)),
      ),
    );
  }
}
