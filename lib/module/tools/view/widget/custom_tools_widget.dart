import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_widget.dart';

class ToolsCardView extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ToolsCardView({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.toolsBgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.themePrimaryBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SvgPicture.asset(imagePath, width: 60, height: 60),
            Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                  Gap(6),
                  CustomText(
                    text: subtitle,
                    fontSize: 10,
                    color: AppColor.subTitleColor,
                    maxLines: 3,
                  ),
                  Gap(6),

                  InkWell(
                    onTap: onTap,
                    child: Row(
                      children: [
                        CustomText(
                          text: "Read more",
                          color: AppColor.themePrimaryColor,
                          fontSize: 11,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2, left: 5),
                          child: SvgPicture.asset(
                            AppImage.arrowRightIcon,
                            color: AppColor.themePrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  customDividerWithOutTopBottomSpace(
                    width: 75,
                    color: AppColor.themePrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
