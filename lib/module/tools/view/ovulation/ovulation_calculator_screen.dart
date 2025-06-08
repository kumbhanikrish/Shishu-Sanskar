import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:table_calendar/table_calendar.dart';

class OvulationCalculatorScreen extends StatefulWidget {
  const OvulationCalculatorScreen({super.key});

  @override
  State<OvulationCalculatorScreen> createState() =>
      _OvulationCalculatorScreenState();
}

class _OvulationCalculatorScreenState extends State<OvulationCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime(2025, 1, 9);
    DateTime? selectedDay = DateTime(2025, 1, 9);
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(
                title: 'Ovulation Calculator',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Select the first day of your last period',
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(10),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.blackColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2030),
                        focusedDay: focusedDay,
                        currentDay: selectedDay,
                        selectedDayPredicate:
                            (day) => isSameDay(day, selectedDay),
                        onDaySelected: (selected, focused) {
                          setState(() {
                            selectedDay = selected;
                            focusedDay = focused;
                          });
                        },
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          titleTextStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.grey,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.calenderHeaderBgColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(0),
                            ),
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: AppColor.themePrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle: TextStyle(color: Colors.black87),
                          weekendTextStyle: TextStyle(color: Colors.black87),
                          outsideDaysVisible: true,
                          outsideTextStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          weekendStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
