import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

String format(DateTime date) {
  return '${_monthAbbr(date.month)} ${date.day}';
}

String _monthAbbr(int month) {
  const months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month];
}

class OvulationCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const OvulationCard({
    required this.title,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontWeight: FontWeight.w600, fontSize: 14),
          CustomText(text: value, fontWeight: FontWeight.w600, fontSize: 14),
        ],
      ),
    );
  }
}

class DayMarker extends StatelessWidget {
  final Color color;
  final DateTime day;
  const DayMarker({super.key, required this.color, required this.day});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      margin: EdgeInsets.all(7),

      alignment: Alignment.center,
      child: CustomText(
        text: day.day.toString(),
        color: AppColor.dateColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }
}
