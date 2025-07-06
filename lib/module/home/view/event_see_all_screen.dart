import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/model/event_model.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class EventSeeAllScreen extends StatelessWidget {
  const EventSeeAllScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        eventCubit.loadMoreEventList(context);
      }
    });
    List<EventModel> eventList = [];
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
                  child: BlocBuilder<EventCubit, EventState>(
                    builder: (context, state) {
                      if (state is GetEventState) {
                        eventList = state.eventList;
                      } else if (state is MoreEventListLoadedState) {
                        eventList = state.eventList;
                      }
                      return eventList.isEmpty
                          ? CustomEmpty()
                          : ListView.separated(
                            itemCount: eventList.length,
                            padding: EdgeInsets.only(top: 10),
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gap(6);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              EventModel eventModel = eventList[index];

                              return customEventCardView(
                                joinNowOnTap: () {},
                                imageUrl: eventModel.imageName,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppPage.eventDetailScreen,
                                    arguments: {'eventModel': eventModel},
                                  );
                                },
                                title: eventModel.title,
                                subTitle: eventModel.description,
                                time: eventModel.time,
                                date:
                                    "${eventModel.date.year.toString().padLeft(4, '0')}/${eventModel.date.month.toString().padLeft(2, '0')}/${eventModel.date.day.toString().padLeft(2, '0')}",
                              );
                            },
                          );
                    },
                  ),
                ),
              ),
              BlocBuilder<EventCubit, EventState>(
                builder: (context, state) {
                  return state is LoadingEventState
                      ? CupertinoActivityIndicator()
                      : SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
