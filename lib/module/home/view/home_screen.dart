import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/model/event_model.dart';

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
    await authCubit.authCategory(context);
    await eventCubit.getEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    List<EventModel> eventList = [];
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
