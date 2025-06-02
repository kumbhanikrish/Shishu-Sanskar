import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Search',
            prefixImage: AppImage.searchIcon,
            onChanged: (value) {},
          ),

          Gap(22),

          SizedBox(
            height: 69.h,
            child: ListView.separated(
              padding: EdgeInsets.zero,

              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.pushNamed(context, AppPage.blogDetailScreen);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: CustomCachedImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',

                          width: 40.w,
                          height: 15.h,
                        ),
                      ),
                      Gap(7),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              CustomText(
                                text: '05 min ago',
                                color: AppColor.seeAllTitleColor,
                                fontSize: 10,
                              ),
                              Gap(4),

                              CustomText(
                                text:
                                    'Lorem Ipsum is simply dummy text of the printing.',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                              Gap(4),
                              CustomText(
                                text:
                                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                                color: AppColor.seeAllTitleColor,
                                fontSize: 10,
                                maxLines: 2,
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
                                      color: AppColor.seeAllTitleColor,
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

                // ListTile(
                //   leading: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //       'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                //     ),
                //   ),
                //   title: Text('Blog Title $index'),
                //   subtitle: Text(
                //     'This is a brief description of the blog post.',
                //   ),
                //   onTap: () {},
                // );
              },
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return Gap(10);
              },
            ),
          ),
        ],
      ),
    );
  }
}
