import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class PrivacyPoliceScreen extends StatelessWidget {
  const PrivacyPoliceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Privacy Police',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(AppImage.privacyPolicy),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        text: 'Privacy Policy',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomText(
                                        text:
                                            "Last updated on October 11, 2023 | Effective from October 11, 2023 ",
                                        fontSize: 12,

                                        color: AppColor.subTitleColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),

                            CustomText(
                              text:
                                  "We at Resala (the “Company”, “we”, or “us”) are committed to safeguarding the privacy of our customers. This Privacy Policy entails the way in which your Personal Information or Usage Information will be collected, used, shared, stored, protected or disclosed by our service (including https://resala.ai). This Privacy Policy applies to the mobile application or website developed by us in relation to services provided to you by the Company from time to time (“Services”). By using our Services, you agree to be bound by the terms of this Privacy Policy. If you do not accept the terms of the Privacy Policy, you are directed to discontinue accessing/using our application in any way. We strongly recommend that you read the policy carefully before proceeding with any transaction on our application.",

                              fontSize: 12,
                              color: AppColor.subTitleColor,
                            ),
                            Gap(20),

                            CustomText(
                              text: 'Why we collect your information?',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            Gap(20),

                            CustomText(
                              text:
                                  "We collect information about you for the following general purposes: For registration and to manage your account, including to facilitate your access to and use of our Services; to communicate with you in general, including to provide information about us; to enable us to publish your reviews, forum posts, and other content; to respond to your questions and comments, to prevent potentially prohibited or illegal activities and to enforce our Terms of Use.",

                              fontSize: 12,
                              color: AppColor.subTitleColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
