import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_list_tile.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Setting',
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
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        border: Border.all(
                          color: AppColor.themePrimaryColor2,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 8.h,
                              height: 8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.themePrimaryColor2,
                                  width: 2,
                                ),
                              ),

                              child: ClipOval(
                                child: Image.asset(
                                  AppImage.user,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: 'Kate Jack Wilson',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Gap(5),
                                  CustomText(
                                    text: 'katewillson@gmail.com',
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppPage.profileScreen,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.themePrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomListTile(
                      text: 'Contact Us',
                      leadingImage: '',
                      fontSize: 14,
                      onTap: () {
                        Navigator.pushNamed(context, AppPage.contactUsScreen);
                      },
                      trailingColor: AppColor.blackColor,
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      text: 'Delete account',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      text: 'Privacy Police',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      text: 'Log out',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
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
