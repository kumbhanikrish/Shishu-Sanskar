import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/blog/cubit/blog_cubit.dart';
import 'package:shishu_sanskar/module/blog/model/blogd_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/formatter/format.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  Timer? debounce;
  ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    BlogCubit blogCubit = BlocProvider.of<BlogCubit>(context);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        blogCubit.loadMoreBlogs(context, search: searchController.text.trim());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlogCubit blogCubit = BlocProvider.of<BlogCubit>(context);

    List<BlogsModel> blogList = [];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 10.h),
        child: SingleChildScrollView(
          controller: scrollController,

          child: Column(
            children: [
              CustomTextField(
                hintText: 'Search',
                prefixImage: AppImage.searchIcon,
                controller: searchController,
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();

                  if (value.length >= 3) {
                    debounce = Timer(Duration(seconds: 3), () {
                      blogCubit.getBlogs(context, search: value);
                    });
                  } else if (value.isEmpty) {
                    blogCubit.getBlogs(context, search: '');
                  }
                },
              ),

              Gap(22),

              BlocBuilder<BlogCubit, BlogState>(
                builder: (context, state) {
                  if (state is GetBlogListState) {
                    blogList = state.blogList;
                  } else if (state is MoreGetBlogListState) {
                    blogList = state.blogList;
                  }

                  return blogList.isEmpty
                      ? SizedBox(
                        height: 60.h,
                        child: Center(child: CustomEmpty()),
                      )
                      : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: blogList.length,

                        itemBuilder: (context, index) {
                          BlogsModel blogsModel = blogList[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppPage.blogDetailScreen,
                                arguments: {'blogsModel': blogsModel},
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: CustomCachedImage(
                                    imageUrl: blogsModel.image,

                                    width: 40.w,
                                    height: 15.h,
                                  ),
                                ),
                                Gap(7),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        CustomText(
                                          text: formatTimeAgo(
                                            blogsModel.createdAt,
                                          ),
                                          color: AppColor.seeAllTitleColor,
                                          fontSize: 10,
                                        ),
                                        Gap(4),

                                        CustomText(
                                          text: blogsModel.title,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        Gap(4),

                                        SizedBox(
                                          height: 30,
                                          child: CustomHTMLText(
                                            text: blogsModel.content,
                                            color: AppColor.seeAllTitleColor,
                                            fontSize: 10,
                                            maxLines: 2,
                                            overflow: true,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Gap(10),
                                        InkWell(
                                          onTap: () {
                                            // Handle read more tap
                                          },
                                          child: Row(
                                            children: [
                                              CustomText(
                                                text: "Read more",
                                                color:
                                                    AppColor.seeAllTitleColor,
                                                fontSize: 11,
                                                maxLines: 2,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 2,
                                                  left: 5,
                                                ),
                                                child: SvgPicture.asset(
                                                  AppImage.arrowRightIcon,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Gap(10);
                        },
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
