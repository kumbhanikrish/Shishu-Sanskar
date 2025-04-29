import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/routes/app_routes.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                        Navigator.pushNamed(context, AppPage.taskDetailScreen);
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
                        Navigator.pushNamed(context, AppPage.taskDetailScreen);
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
                        Navigator.pushNamed(context, AppPage.taskDetailScreen);
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
              onTap: () {},
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.eventTitleColor,
            ),
          ],
        ),
      ),
    );
  }
}
