import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
import 'package:shishu_sanskar/module/profile/model/user_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class PlanHistoryScreen extends StatefulWidget {
  const PlanHistoryScreen({super.key});

  @override
  State<PlanHistoryScreen> createState() => _PlanHistoryScreenState();
}

class _PlanHistoryScreenState extends State<PlanHistoryScreen> {
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
                title: 'Plan History',
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
                      return userDataModel.subscriptions.isEmpty
                          ? CustomEmpty()
                          : ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: userDataModel.subscriptions.length,
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gap(10);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              Subscription subscription =
                                  userDataModel.subscriptions[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  border: Border.all(
                                    color: AppColor.themePrimaryColor2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(12),

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(AppImage.online),
                                          Gap(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text:
                                                    subscription.plan?.title ??
                                                    '',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),

                                              CustomText(
                                                text: DateFormat(
                                                  'dd MMM yyyy',
                                                ).format(
                                                  subscription
                                                          .plan
                                                          ?.createdAt ??
                                                      DateTime.now(),
                                                ),
                                                fontSize: 12,
                                                color: AppColor.subTitleColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: '₹${subscription.plan?.price}',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.themePrimaryColor,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.greenColor,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 8,
                                          ),
                                          child: CustomText(
                                            text:
                                                '${subscription.status[0].toUpperCase()}${subscription.status.substring(1)}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
