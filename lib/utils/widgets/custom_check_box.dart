import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

class CustomCheckbox extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomCheckbox({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: Row(
            children: [
              SvgPicture.asset(
                isSelected
                    ? AppImage.checkboxChecked
                    : AppImage.checkboxUnchecked,
              ),
              Gap(10),
              Expanded(child: CustomText(text: title, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
