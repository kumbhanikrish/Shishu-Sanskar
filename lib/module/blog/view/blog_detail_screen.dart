import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/blog/model/blogd_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class BlogDetailScreen extends StatelessWidget {
  final dynamic argument;
  const BlogDetailScreen({super.key, this.argument});
  @override
  Widget build(BuildContext context) {
    BlogsModel blogsModel = argument['blogsModel'];

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
                            imageUrl: blogsModel.image,

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
                          text: blogsModel.title,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(10),

                        CustomHTMLText(
                          text: blogsModel.description,
                          color: AppColor.seeAllTitleColor,
                          fontSize: 12,
                          textAlign: TextAlign.start,
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
