import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Contact Us',
                onTap: () {
              
                Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Contact us', fontSize: 14),
                    Gap(10),
                    CustomText(
                      text:
                          'Email, call, or complete the form to learn how Shishu sanskar can help you.',

                      color: AppColor.seeAllTitleColor,
                    ),
                    Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(AppImage.mail2, height: 13, width: 12),
                        Gap(10),
                        CustomText(
                          text: 'support@shishusanskar.com',
                          color: AppColor.seeAllTitleColor,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Gap(10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(AppImage.call, height: 13, width: 12),
                        Gap(10),
                        CustomText(
                          text: '+91 90237 65538',
                          color: AppColor.seeAllTitleColor,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(AppImage.facebook),
                        Gap(10),
                        SvgPicture.asset(AppImage.instagram),
                        Gap(10),

                        SvgPicture.asset(AppImage.linkedin),
                        Gap(10),

                        SvgPicture.asset(AppImage.twitter),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
