import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),

          Column(
            children: [
              customAppBar(
                title: 'Blog Detail',
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CustomCachedImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',

                            width: 100.w,
                            height: 20.h,
                          ),
                        ),
                        Gap(10),

                        CustomText(
                          text: '05 min ago',
                          fontSize: 10,
                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(10),

                        CustomText(
                          text:
                              'Lorem Ipsum is simply dummy text of the printing.',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),

                        CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                          fontSize: 12,
                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(10),

                        CustomText(
                          text:
                              "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          fontSize: 12,
                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(10),

                        CustomText(
                          text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                          fontSize: 12,
                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(10.h),

                        BlocBuilder<PasswordVisibilityCubit, bool>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                CustomText(
                                  text: 'Vote us',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                Gap(6),

                                LikeButton(
                                  size: 20,
                                  circleColor: CircleColor(
                                    start: AppColor.themePrimaryColor,
                                    end: AppColor.themePrimaryColor,
                                  ),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: AppColor.themePrimaryColor,
                                    dotSecondaryColor:
                                        AppColor.themePrimaryColor,
                                  ),
                                  likeBuilder: (isLiked) {
                                    return SvgPicture.asset(
                                      isLiked
                                          ? AppImage.likeIconFilled
                                          : AppImage.likeIcon,
                                    );
                                  },
                                ),

                                Gap(6),
                                LikeButton(
                                  size: 20,
                                  circleColor: CircleColor(
                                    start: AppColor.disLikeColor,
                                    end: AppColor.disLikeColor,
                                  ),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: AppColor.disLikeColor,
                                    dotSecondaryColor: AppColor.disLikeColor,
                                  ),
                                  likeBuilder: (isLiked) {
                                    return SvgPicture.asset(
                                      isLiked
                                          ? AppImage.dislikeIconFilled
                                          : AppImage.dislikeIcon,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        Gap(20.h),
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
