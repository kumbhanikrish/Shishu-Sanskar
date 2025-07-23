import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     SvgPicture.asset(AppImage.privacyPolicy),
                        //     const SizedBox(width: 12),
                        //     Expanded(
                        //       child: const CustomText(
                        //         text: 'Privacy Policy',
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Gap(20),
                        CustomText(
                          text: """
This Privacy Policy is meant to help you understand what information we collect, why we collect it, and how you can update, manage, and delete your information.
Shishusanskar built the Shishusanskar app and website as a freemium service. This SERVICE is provided by Shishusanskar at no cost for basic features and with optional premium services. It is intended for use as is.
This page is used to inform visitors and users regarding our policies with the collection, use, and disclosure of Personal Information if anyone decides to use our Service.
If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.
The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, unless otherwise defined in this Privacy Policy.""",
                          fontSize: 12,
                          color: AppColor.subTitleColor,
                        ),
                        Gap(10),

                        CustomText(
                          text: 'Information Collection and Use',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),

                        CustomText(
                          text: """
For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to:
• Full Name
• Email Address
• Mobile Number
• Gender
• Pregnancy stage or due date
• App usage patterns and preferences
The information that we request is retained by us and used as described in this privacy policy.
The app does use third-party services that may collect information used to identify you.
                """,

                          fontSize: 12,
                          color: AppColor.subTitleColor,
                        ),
                        Gap(10),

                        CustomText(
                          text: 'Third-party service providers may include:',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),
                        CustomText(
                          text: """
• Google Play Services
• Firebase Analytics
• Crashlytics
                """,

                          fontSize: 12,
                          color: AppColor.subTitleColor,
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
