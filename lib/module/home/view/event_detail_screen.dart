import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'Event Detail',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customEventCardView(
                          onTap: () {},
                          mainHeight: 22.h,
                          title:
                              "Lorem Ipsum is simply dummy text of the printing.",
                          subTitle:
                              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                          time: '04:30 PM  to 06:30 PM',
                          date: '02/02/2026',
                          showButton: false,
                        ),
                        Gap(7),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                text: 'Book Your Seat',
                                padding: EdgeInsets.symmetric(vertical: 8),
                                onTap: () {},
                              ),
                            ),
                            Gap(4),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.themePrimaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(AppImage.share),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        CustomText(
                          text: 'Lorem Ipsum is simply dummy text',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(5),
                        CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(20),
                        CustomText(
                          text: 'main point',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(5),
                        CustomText(
                          text:
                              '• Lorem Ipsum is simply dummy text of the printing',
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(5),
                        CustomText(
                          text:
                              '• Lorem Ipsum is simply dummy text of the printing',
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(5),
                        CustomText(
                          text:
                              '• Lorem Ipsum is simply dummy text of the printing',
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(5),
                        CustomText(
                          text:
                              '• Lorem Ipsum is simply dummy text of the printing',
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(20),
                        CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(20),
                        CustomText(
                          text: 'Speaker:',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(5),

                        Row(
                          children: [
                            Container(
                              width: 63,
                              height: 63,
                              decoration: BoxDecoration(
                                color: AppColor.themePrimaryColor2,

                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  AppImage.user,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Krutika Gajjar, ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.seeAllTitleColor,
                                    overflow: TextOverflow.visible,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'certified Yoga Trainor Pre and Postnatal Yoga Trainor Pregnancy Counselor Garbhsanskar Counselor',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.visible,
                                        color: AppColor.seeAllTitleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
