import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class TaskSeeAllScreen extends StatelessWidget {
  const TaskSeeAllScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'Today Task',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
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
