import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

customDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String cancelText,
  required String submitText,
  required void Function() submitOnTap,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColor.themePrimaryColor2.withOpacity(0.5),
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),

              CustomText(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              Gap(8),
              CustomText(
                text: subtitle,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.subTitleColor,
              ),
              Gap(20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextButton(
                      text: cancelText,
                      color: AppColor.themePrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: CustomButton(
                      borderColor: AppColor.borderColor,
                      text: submitText,
                      backgroundColor: AppColor.themePrimaryColor,
                      onTap: submitOnTap,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
