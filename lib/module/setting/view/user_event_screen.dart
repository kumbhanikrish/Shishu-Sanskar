import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
import 'package:shishu_sanskar/module/profile/model/user_model.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class UserEventScreen extends StatefulWidget {
  const UserEventScreen({super.key});

  @override
  State<UserEventScreen> createState() => _UserEventScreenState();
}

class _UserEventScreenState extends State<UserEventScreen> {
  @override
  void initState() {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    profileCubit.getUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'User Event',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is GetUserDataState) {
                        userDataModel = state.userDataModel;
                      }
                      return userDataModel.userEvents.isEmpty
                          ? CustomEmpty()
                          : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: userDataModel.userEvents.length,
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gap(10);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              UserEvent userEvent =
                                  userDataModel.userEvents[index];
                              return customEventCardView(
                                showButton: false,
                                joinNowOnTap: () async {
                                  // eventCubit.joinEvent(
                                  //   context,
                                  //   eventId: userEvent.id,
                                  // );
                                  // final url = Uri.parse(eventModel.link);

                                  // await launchUrl(
                                  //   url,
                                  //   mode: LaunchMode.externalApplication,
                                  // );
                                },
                                imageUrl: userEvent.image,

                                mainWidth: 88.w,
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //   context,
                                  //   AppPage.eventDetailScreen,
                                  //   arguments: {'eventModel': eventModel},
                                  // );
                                },
                                title: userEvent.title,
                                subTitle: userEvent.description,
                                time: userEvent.time,
                                date:
                                    "${userEvent.date.year.toString().padLeft(4, '0')}/${userEvent.date.month.toString().padLeft(2, '0')}/${userEvent.date.day.toString().padLeft(2, '0')}",
                              );
                            },
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
