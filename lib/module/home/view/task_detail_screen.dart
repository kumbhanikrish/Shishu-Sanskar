import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/task/task_cubit.dart';
import 'package:shishu_sanskar/module/home/model/task_model.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_check_box.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskDetailScreen extends StatefulWidget {
  final dynamic data;
  const TaskDetailScreen({super.key, this.data});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Today taskDetail = widget.data['taskDetail'];
    TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);

    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Gap(5.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CustomCachedImage(
                        width: 100.w,
                        height: 17.h,

                        imageUrl: taskDetail.image ?? '',
                      ),
                      Image.asset(
                        AppImage.taskDetailCard,
                        width: 100.w,
                        height: 17.h,
                        fit: BoxFit.cover,
                      ),
                      customAppBar(
                        title: taskDetail.category,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        topGap: false,
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemCount: taskDetail.tasks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return customDivider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final task = taskDetail.tasks[index];
                      final type = task.type;
                      final description = task.description;

                      Widget descriptionWidget;

                      switch (type) {
                        case 'video_url':
                        case 'audio_url':
                        case 'web_url':
                          final Uri url = Uri.parse(description.toString());
                          descriptionWidget = GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                customErrorToast(
                                  context,
                                  text: 'Could not launch URL',
                                );
                              }
                            },
                            child: CustomText(
                              text: description,
                              fontSize: 12,
                              decorationColor: AppColor.blueColor,
                              color: AppColor.blueColor,
                              decoration: TextDecoration.underline,
                            ),
                          );
                          break;

                        case 'text':
                          descriptionWidget = CustomText(
                            text: description,
                            fontSize: 12,
                            color: AppColor.seeAllTitleColor,
                          );
                          break;

                        case 'checkbox':
                          descriptionWidget = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                (description as List).map<Widget>((item) {
                                  return CustomCheckbox(
                                    title: item,
                                    isSelected: true,
                                    onTap: () {},
                                  );
                                }).toList(),
                          );
                          break;

                        case 'images':
                          descriptionWidget = Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                (description as List).map<Widget>((imgUrl) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CustomCachedImage(imageUrl: imgUrl),
                                  );
                                }).toList(),
                          );
                          break;

                        case 'video':
                          descriptionWidget = CustomVideoPlayer(
                            videoUrl: description.toString(),
                          );
                          break;
                        case 'audio':
                          descriptionWidget = CustomAudioPlayer(
                            audioUrl: description.toString(),
                          );
                          break;

                        default:
                          descriptionWidget = CustomText(
                            text: 'Unsupported task type',
                            fontSize: 12,
                            color: Colors.red,
                          );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CustomText(
                                text: 'Task ${index + 1}',
                                fontSize: 12,
                                color: AppColor.seeAllTitleColor,
                              ),
                              Gap(10),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColor.themeSecondaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.all(5),
                                child: CustomText(
                                  text:
                                      '${task.status[0].toUpperCase()}${task.status.substring(1)}',
                                  fontSize: 10,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          Gap(5),
                          CustomText(
                            text: task.title,
                            fontWeight: FontWeight.w600,
                          ),
                          Gap(5),
                          descriptionWidget,
                          Gap(10),
                          CustomButton(
                            text:
                                '${task.status[0].toUpperCase()}${task.status.substring(1)}',
                            backgroundColor:
                                task.status == 'completed'
                                    ? AppColor.themePrimaryColor2
                                    : AppColor.themePrimaryColor,
                            borderColor:
                                task.status == 'completed'
                                    ? AppColor.themePrimaryColor2
                                    : AppColor.themePrimaryColor,
                            onTap:
                                task.status == 'completed'
                                    ? () {}
                                    : () {
                                      setState(() {});
                                      taskCubit.completeTask(
                                        context,
                                        taskId: task.id,
                                      );
                                    },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
