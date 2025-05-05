import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';

class EventSeeAllScreen extends StatelessWidget {
  const EventSeeAllScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'All Event',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemCount: 10,
                    padding: EdgeInsets.only(top: 10),
                    separatorBuilder: (BuildContext context, int index) {
                      return Gap(6);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return customEventCardView(
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
                    },
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
