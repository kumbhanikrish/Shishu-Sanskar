import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Gap(5.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CustomCachedImage(
                        width: 100.w,
                        height: 17.h,

                        imageUrl:
                            'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                      ),
                      Image.asset(
                        AppImage.taskDetailCard,
                        width: 100.w,
                        height: 17.h,
                        fit: BoxFit.cover,
                      ),
                      customAppBar(
                        title: 'Affirmations',
                        onTap: () {
                          Navigator.pop(context);
                        },
                        topGap: false,
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Expanded(
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) {
                      return customDivider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CustomText(
                                  text: 'Task 1',
                                  fontSize: 12,
                                  color: AppColor.seeAllTitleColor,
                                ),
                                Gap(10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.themeSecondaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: CustomText(
                                    text: 'Completed',
                                    fontSize: 10,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            Gap(5),
                            CustomText(
                              text: 'Lorem Ipsum is simply dummy text',
                              fontWeight: FontWeight.w600,
                            ),
                            Gap(5),
                            CustomText(
                              text:
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",

                              fontSize: 12,
                            ),
                            Gap(10),
                            CustomButton(text: 'Completed', onTap: () {}),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
