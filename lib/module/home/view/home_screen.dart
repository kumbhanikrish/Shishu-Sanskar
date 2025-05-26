import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //// Today task
              customTitleAnsSeeAll(
                title: 'Today task',
                onTap: () {
                  Navigator.pushNamed(context, AppPage.taskSeeAllScreen);
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 13, left: 20),
                  child: Row(
                    children: List.generate(20, (index) {
                      return customCardView(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskDetailScreen,
                          );
                        },
                        image:
                            'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                        title: 'Affirmations',
                      );
                    }),
                  ),
                ),
              ),

              //// Daily task
              customTitleAnsSeeAll(title: 'Daily task', onTap: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 13, left: 20),
                  child: Row(
                    children: List.generate(20, (index) {
                      return customCardView(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskDetailScreen,
                          );
                        },
                        image:
                            'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                        title: 'Yoga',
                      );
                    }),
                  ),
                ),
              ),

              //// weekly task
              customTitleAnsSeeAll(title: 'weekly task', onTap: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 13, left: 20),
                  child: Row(
                    children: List.generate(20, (index) {
                      return customCardView(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskDetailScreen,
                          );
                        },
                        image:
                            'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                        title: 'Yoga',
                      );
                    }),
                  ),
                ),
              ),

              //// event
              Gap(10),
              customTitleAnsSeeAll(
                title: 'Event',
                onTap: () {
                  Navigator.pushNamed(context, AppPage.eventSeeAllScreen);
                },
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.eventTitleColor,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 13, left: 20),
                  child: Row(
                    children: List.generate(20, (index) {
                      return customEventCardView(
                        mainWidth: 88.w,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.eventDetailScreen,
                          );
                        },
                        title:
                            "Lorem Ipsum is simply dummy text of the printing.",
                        subTitle:
                            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                        time: '04:30 PM  to 06:30 PM',
                        date: '02/02/2026',
                      );
                    }),
                  ),
                ),
              ),
              Gap(5.h),
            ],
          ),
        ),
      ),
    );
  }
}
