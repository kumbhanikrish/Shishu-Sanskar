import 'package:calendar_date_picker2/calendar_date_picker2.dart';
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

void customDatePicker(
  BuildContext context, {
  required List<DateTime?> value,
  required ValueChanged<List<DateTime?>> onValueChanged,
  ValueChanged<DateTime>? onDisplayedMonthChanged,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            height: 263,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectedDayHighlightColor: AppColor.themePrimaryColor,
                centerAlignModePicker: true,

                disableModePicker: true,
                dayTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                weekdayLabelTextStyle: TextStyle(
                  color: AppColor.calendarControlColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                controlsTextStyle: TextStyle(
                  color: AppColor.calendarControlColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                lastMonthIcon: Icon(
                  Icons.chevron_left,
                  color: AppColor.calendarControlColor,
                ),
                nextMonthIcon: Icon(
                  Icons.chevron_right,
                  color: AppColor.calendarControlColor,
                ),
                selectedDayTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                todayTextStyle: TextStyle(
                  color: AppColor.themePrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                firstDate: firstDate ?? DateTime(2000),
                lastDate: lastDate ?? DateTime(2100),
              ),
              value: value,
              onValueChanged: onValueChanged,
              onDisplayedMonthChanged: onDisplayedMonthChanged,
            ),
          ),
        ),
      );
    },
  );
}
