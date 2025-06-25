import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/home/model/task_model.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:sizer/sizer.dart';

class TaskSeeAllScreen extends StatelessWidget {
  final dynamic data;
  const TaskSeeAllScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    TaskModel taskList = data['taskList'];
    String title = data['title'];
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: title,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      title == 'Today task'
                          ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: taskList.today.length,
                            itemBuilder: (BuildContext context, int index) {
                              Today today = taskList.today[index];
                              return customCardView(
                                width: 100.w,
                                height: 17.h,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.taskDetailScreen,
                                  );
                                },
                                image: today.image ?? '',
                                title: today.category,
                              );
                            },
                          )
                          : title == 'Daily task'
                          ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: taskList.daily.length,
                            itemBuilder: (BuildContext context, int index) {
                              Today daily = taskList.daily[index];
                              return customCardView(
                                width: 100.w,
                                height: 17.h,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.taskDetailScreen,
                                  );
                                },
                                image: daily.image ?? '',
                                title: daily.category,
                              );
                            },
                          )
                          : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: taskList.weekly.length,
                            itemBuilder: (BuildContext context, int index) {
                              Today weekly = taskList.weekly[index];
                              return customCardView(
                                width: 100.w,
                                height: 17.h,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.taskDetailScreen,
                                  );
                                },
                                image: weekly.image ?? '',
                                title: weekly.category,
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
