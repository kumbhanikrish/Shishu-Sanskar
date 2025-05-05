import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/pricing/view/widget/custom_pricing_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Gap(20),
                  CustomText(
                    text: "Shishu sanskar's Flexible, Affordable Pricing",
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                  ),
                  Gap(30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          customPricingCard(
                            image: AppImage.offline,
                            name: 'Offline',
                            price: '₹15,000',
                            onTap: () {},
                            backgroundColor: AppColor.themePrimaryColor,
                            child: Column(
                              children: [
                                customDoneIconAndText(text: 'Daily Activity'),
                                customDoneIconAndText(text: 'Family Harmony'),
                                customDoneIconAndText(
                                  text: 'Musical Pregnancy',
                                ),
                                customDoneIconAndText(text: 'Yoga & Diet'),
                                customDoneIconAndText(text: 'Advance Workshop'),
                                customDoneIconAndText(
                                  text: 'Advance Expert Sessions',
                                ),
                                customDoneIconAndText(
                                  text: 'Advance Material Kit',
                                ),
                                customDoneIconAndText(text: 'Live Q&A Session'),
                                customDoneIconAndText(
                                  text: 'Counselling & Support',
                                  icon: Icons.remove_rounded,
                                  color: AppColor.greyColor,
                                ),
                              ],
                            ),
                          ),
                          Gap(20),
                          customPricingCard(
                            image: AppImage.online,
                            name: 'Online',
                            price: '₹15,000',
                            onTap: () {},
                            textColor: AppColor.themePrimaryColor,
                            backgroundColor: AppColor.whiteColor,
                            borderColor: AppColor.themePrimaryColor,
                            child: Column(
                              children: [
                                customDoneIconAndText(text: 'Daily Activity'),
                                customDoneIconAndText(text: 'Family Harmony'),
                                customDoneIconAndText(
                                  text: 'Musical Pregnancy',
                                ),
                                customDoneIconAndText(text: 'Yoga & Diet'),
                                customDoneIconAndText(text: 'Advance Workshop'),
                                customDoneIconAndText(
                                  text: 'Advance Expert Sessions',
                                ),
                                customDoneIconAndText(
                                  text: 'Advance Material Kit',
                                ),
                                customDoneIconAndText(
                                  text: 'Live Q&A Session',
                                  icon: Icons.remove_rounded,
                                  color: AppColor.greyColor,
                                ),
                                customDoneIconAndText(
                                  text: 'Counselling & Support',
                                  icon: Icons.remove_rounded,
                                  color: AppColor.greyColor,
                                ),
                              ],
                            ),
                          ),
                          Gap(5.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,

            left: 0,
            right: 0,
            child: SizedBox(
              height: 20.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.whiteColor.withOpacity(0),
                          AppColor.whiteColor.withOpacity(0.95),
                          AppColor.whiteColor.withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
