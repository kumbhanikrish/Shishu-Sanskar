import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalender extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime, DateTime)? onDaySelected;
  final Widget? Function(BuildContext, DateTime, DateTime)? defaultBuilder;
  final bool Function(DateTime)? selectedDayPredicate;
  final Color? headerColor;
  const CustomCalender({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    this.onDaySelected,
    this.defaultBuilder,
    this.selectedDayPredicate,
    this.headerColor,
  });
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2000),
      lastDay: DateTime(2030),
      focusedDay: focusedDay,
      currentDay: selectedDay,
      selectedDayPredicate: (day) {
        return isSameDay(day, selectedDay);
      },
      onDaySelected: onDaySelected,
      calendarBuilders: CalendarBuilders(defaultBuilder: defaultBuilder),

      headerStyle: HeaderStyle(
        headerMargin: EdgeInsets.only(bottom: 10),
        titleCentered: true,
        formatButtonVisible: false,
        headerPadding: EdgeInsets.all(0),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColor.dateColor,
          fontFamily: 'Caros Soft',
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: AppColor.subTitleColor,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: AppColor.subTitleColor,
        ),
        decoration: BoxDecoration(
          color: headerColor ?? AppColor.calenderHeaderBgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColor.themePrimaryColor,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColor.themePrimaryColor,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Caros Soft',
        ),
        defaultTextStyle: TextStyle(
          color: AppColor.dateColor,
          fontFamily: 'Caros Soft',
        ),
        weekendTextStyle: TextStyle(
          color: AppColor.dateColor,
          fontFamily: 'Caros Soft',
        ),
        outsideDaysVisible: true,
        outsideTextStyle: TextStyle(
          color: AppColor.outDateColor,
          fontFamily: 'Caros Soft',
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: 'Caros Soft',

          color: AppColor.weekColor,
        ),
        weekendStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          fontFamily: 'Caros Soft',

          color: AppColor.weekColor,
        ),
      ),
    );
  }
}
