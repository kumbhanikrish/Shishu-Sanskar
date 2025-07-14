import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/model/event_model.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatelessWidget {
  final dynamic argument;
  const EventDetailScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    EventModel eventModel = argument['eventModel'];
    EventCubit eventCubit = BlocProvider.of<EventCubit>(context);

    log("Event Detail Screen: ${eventModel.link}");
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'Event Detail',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customEventCardView(
                          imageUrl: eventModel.imageName,
                          joinNowOnTap: () {},
                          onTap: () {},
                          mainHeight: 22.h,
                          title: eventModel.title,
                          subTitle: '',
                          time: eventModel.time,
                          date:
                              "${eventModel.date.year.toString().padLeft(4, '0')}/${eventModel.date.month.toString().padLeft(2, '0')}/${eventModel.date.day.toString().padLeft(2, '0')}",

                          showButton: false,
                        ),
                        Gap(7),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: CustomButton(
                                text:
                                    eventModel.isLoginUserEventsParticipation
                                        ? 'Deregister'
                                        : 'Book Your Seat',
                                padding: EdgeInsets.symmetric(vertical: 8),
                                onTap: () {
                                  eventCubit.joinEvent(
                                    context,
                                    eventId: eventModel.id,
                                    detail: true,
                                  );
                                },
                              ),
                            ),
                            Gap(4),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.themePrimaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (eventModel.link.isNotEmpty) {
                                    launchUrl(Uri.parse(eventModel.link));
                                  } else {
                                    log("No link available for this event");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(AppImage.share),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        CustomText(
                          text: eventModel.description,
                          fontSize: 12,

                          color: AppColor.seeAllTitleColor,
                        ),

                        Gap(20),
                        CustomText(
                          text: 'Speaker:',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Gap(10),

                        Row(
                          children: [
                            Container(
                              width: 63,
                              height: 63,
                              decoration: BoxDecoration(
                                color: AppColor.themePrimaryColor2,

                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  AppImage.user,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Krutika Gajjar, ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.seeAllTitleColor,
                                    overflow: TextOverflow.visible,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'certified Yoga Trainor Pre and Postnatal Yoga Trainor Pregnancy Counselor Garbhsanskar Counselor',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.visible,
                                        color: AppColor.seeAllTitleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
