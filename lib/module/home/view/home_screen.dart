import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/task/task_cubit.dart';
import 'package:shishu_sanskar/module/home/model/event_model.dart';
import 'package:shishu_sanskar/module/home/model/task_model.dart';

import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    callApi();
    super.initState();
  }

  callApi() async {
    EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
    await authCubit.authCategory(context);
    await eventCubit.getEvent(context);
    await taskCubit.getTask(context);
  }

  @override
  Widget build(BuildContext context) {
    List<EventModel> eventList = [];

    TaskModel taskList = TaskModel(today: [], weekly: [], daily: []);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is GetTaskState) {
                    taskList = state.taskModel;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //// Today task
                      customTitleAnsSeeAll(
                        title: 'Today task',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskSeeAllScreen,
                            arguments: {
                              'taskList': taskList,

                              'title': 'Today task',
                            },
                          );
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13, left: 20),
                          child: Row(
                            children: List.generate(taskList.today.length, (
                              index,
                            ) {
                              Today today = taskList.today[index];
                              return taskList.today.isEmpty
                                  ? CustomEmpty()
                                  : customCardView(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppPage.taskDetailScreen,
                                        arguments: {'taskDetail': today},
                                      );
                                    },
                                    image: today.image ?? '',
                                    title: today.category,
                                  );
                            }),
                          ),
                        ),
                      ),

                      //// Daily task
                      customTitleAnsSeeAll(
                        title: 'Daily task',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskSeeAllScreen,
                            arguments: {
                              'taskList': taskList,
                              'title': 'Daily task',
                            },
                          );
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13, left: 20),
                          child: Row(
                            children: List.generate(taskList.daily.length, (
                              index,
                            ) {
                              Today daily = taskList.daily[index];
                              return customCardView(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.taskDetailScreen,
                                    arguments: {'taskDetail': daily},
                                  );
                                },
                                image: daily.image ?? '',
                                title: daily.category,
                              );
                            }),
                          ),
                        ),
                      ),

                      //// weekly task
                      customTitleAnsSeeAll(
                        title: 'Weekly task',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppPage.taskSeeAllScreen,
                            arguments: {
                              'taskList': taskList,
                              'title': 'Weekly task',
                            },
                          );
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13, left: 20),
                          child: Row(
                            children: List.generate(taskList.weekly.length, (
                              index,
                            ) {
                              Today weekly = taskList.weekly[index];

                              return customCardView(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.taskDetailScreen,
                                    arguments: {'taskDetail': weekly},
                                  );
                                },
                                image: weekly.image ?? '',
                                title: weekly.category,
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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

              BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  if (state is GetEventState) {
                    eventList = state.eventList;
                  } else if (state is MoreEventListLoadedState) {
                    eventList = state.eventList;
                  }
                  return eventList.isEmpty
                      ? CustomEmpty()
                      : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13, left: 20),
                          child: Row(
                            children: List.generate(eventList.length, (index) {
                              EventModel eventModel = eventList[index];

                              return customEventCardView(
                                joinNowOnTap: () async {
                                  final url = Uri.parse(eventModel.link);

                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                imageUrl: eventModel.imageName,

                                mainWidth: 88.w,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.eventDetailScreen,
                                  );
                                },
                                title: eventModel.title,
                                subTitle: eventModel.description,
                                time: eventModel.time,
                                date:
                                    "${eventModel.date.year.toString().padLeft(4, '0')}/${eventModel.date.month.toString().padLeft(2, '0')}/${eventModel.date.day.toString().padLeft(2, '0')}",
                              );
                            }),
                          ),
                        ),
                      );
                },
              ),
              Gap(5.h),
            ],
          ),
        ),
      ),
    );
  }
}
