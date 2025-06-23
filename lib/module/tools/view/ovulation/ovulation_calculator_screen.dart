import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/tools/cubit/ovulation_calculator/cubit/ovulation_calculator_cubit.dart';
import 'package:shishu_sanskar/module/tools/view/ovulation/widget/custom_ovulation_widget.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_calender.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:table_calendar/table_calendar.dart';

class OvulationCalculatorScreen extends StatefulWidget {
  const OvulationCalculatorScreen({super.key});

  @override
  State<OvulationCalculatorScreen> createState() =>
      _OvulationCalculatorScreenState();
}

class _OvulationCalculatorScreenState extends State<OvulationCalculatorScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  List<String> averageCycle = List.generate(
    36,
    (index) => (15 + index).toString(),
  );
  List<DateTime> fertileWindow = [];

  DateTime? fertileStart;
  DateTime? fertileEnd;
  DateTime? ovulationDay;
  DateTime? nextPeriod;
  DateTime? pregnancyTestDay;
  DateTime? estimatedDueDate;
  @override
  Widget build(BuildContext context) {
    OvulationCalculatorCubit ovulationCalculatorCubit =
        BlocProvider.of<OvulationCalculatorCubit>(context);
    SelectCalenderCubit selectCalenderCubit =
        BlocProvider.of<SelectCalenderCubit>(context);
    SelectCycleCubit selectCycleCubit = BlocProvider.of<SelectCycleCubit>(
      context,
    );

    ovulationCalculatorCubit.init();
    selectCalenderCubit.init();
    selectCycleCubit.init();

    selectCalenderCubit.updateSelectedDay(DateTime.now(), DateTime.now());
    List<DateTime> fertileWindow = [];

    DateTime? fertileStart = DateTime.now();
    DateTime? fertileEnd = DateTime.now();
    DateTime? ovulationDay = DateTime.now();
    DateTime? nextPeriod = DateTime.now();
    DateTime? pregnancyTestDay = DateTime.now();
    DateTime? estimatedDueDate = DateTime.now();
    DateTime? normalizedDay = DateTime.now();

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(20),
                        CustomText(
                          text: 'Select the first day of your last period',
                          fontWeight: FontWeight.w500,
                        ),

                        Gap(10),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.toolsBgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: BlocBuilder<
                            SelectCalenderCubit,
                            SelectCalenderState
                          >(
                            builder: (context, state) {
                              if (state is SelectCalenderValueState) {
                                focusedDay = state.focusedDay;
                                selectedDay = state.selectedDay;
                              }
                              return BlocBuilder<
                                OvulationCalculatorCubit,
                                OvulationCalculatorState
                              >(
                                builder: (context, state) {
                                  if (state is OvulationCalculatorResult) {
                                    fertileStart = state.fertileStart;
                                    fertileEnd = state.fertileEnd;
                                    ovulationDay = state.ovulationDay;
                                    nextPeriod = state.nextPeriod;
                                    pregnancyTestDay = state.pregnancyTestDay;
                                    estimatedDueDate = state.estimatedDueDate;

                                    fertileWindow = List.generate(
                                      state.fertileEnd
                                              .difference(state.fertileStart)
                                              .inDays +
                                          1,
                                      (index) => DateTime(
                                        state.fertileStart.year,
                                        state.fertileStart.month,
                                        state.fertileStart.day + index,
                                      ),
                                    );
                                  }
                                  return CustomCalender(
                                    focusedDay: focusedDay,
                                    selectedDay: selectedDay,
                                    selectedDayPredicate: (day) {
                                      return isSameDay(day, selectedDay);
                                    },
                                    onDaySelected:
                                        (state is OvulationCalculatorResult)
                                            ? null
                                            : (selected, focused) {
                                              log(
                                                'selectedselected ::$selected',
                                              );
                                              selectCalenderCubit
                                                  .updateSelectedDay(
                                                    selected,
                                                    focused,
                                                  );
                                            },
                                    defaultBuilder: (context, day, focusedDay) {
                                      normalizedDay = DateTime(
                                        day.year,
                                        day.month,
                                        day.day,
                                      );

                                      log('normalizedDay ::$normalizedDay');

                                      // Prioritize more specific markers first:
                                      if (ovulationDay != null &&
                                          isSameDay(
                                            normalizedDay,
                                            ovulationDay,
                                          )) {
                                        return DayMarker(
                                          day: day,
                                          color:
                                              (state is OvulationCalculatorResult)
                                                  ? Color(0xFFDBFCE7)
                                                  : AppColor.transparentColor,
                                        );
                                      }

                                      if (fertileWindow.contains(
                                        normalizedDay,
                                      )) {
                                        return DayMarker(
                                          day: day,
                                          color: Color(0xFFDBEAFE),
                                        );
                                      }

                                      if (nextPeriod != null &&
                                          isSameDay(
                                            normalizedDay,
                                            nextPeriod,
                                          )) {
                                        return DayMarker(
                                          day: day,
                                          color: Color(0xFFFFE2E2),
                                        );
                                      }

                                      if (pregnancyTestDay != null &&
                                          isSameDay(
                                            normalizedDay,
                                            pregnancyTestDay,
                                          )) {
                                        return DayMarker(
                                          day: day,
                                          color: Color(0xFFFEF9C2),
                                        );
                                      }
                                      log(
                                        'estimatedDueDateestimatedDueDate :${isSameDay(normalizedDay, estimatedDueDate)}',
                                      );
                                      if (estimatedDueDate != null &&
                                          isSameDay(
                                            normalizedDay,
                                            estimatedDueDate,
                                          )) {
                                        return DayMarker(
                                          day: day,
                                          color: Color(0xFFF3E8FF),
                                        );
                                      }

                                      return null;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Gap(10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Note: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: AppColor.blackColor,
                                  fontFamily: 'Caros Soft',
                                ),
                              ),
                              TextSpan(
                                text:
                                    'This tool should not be used alone to prevent pregnancy. Results are estimates as ovulation cycles can vary.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: AppColor.blackColor,
                                  fontFamily: 'Caros Soft',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20),

                        BlocBuilder<
                          OvulationCalculatorCubit,
                          OvulationCalculatorState
                        >(
                          builder: (context, ovulationState) {
                            return (ovulationState is OvulationCalculatorResult)
                                ? SizedBox()
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'How Long Is Your Average Cycle?',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Gap(20),
                                    CustomDropWonFiled<String>(
                                      text: '',
                                      selectColor: AppColor.themePrimaryColor,
                                      items: averageCycle,
                                      initialItem: '28',
                                      onChanged: (value) {
                                        selectCycleCubit.updateValue(
                                          cycleValue: value ?? '',
                                        );
                                      },
                                    ),
                                    Gap(20),
                                  ],
                                );
                          },
                        ),
                        // Gap(10),
                        // CustomRowText(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   text: 'Don’t know? ',
                        //   fontSize: 14,

                        //   child: CustomText(
                        //     text: 'Calculate your Cycle Length',
                        //     fontSize: 14,
                        //     color: AppColor.themePrimaryColor,
                        //   ),
                        // ),
                        BlocBuilder<
                          OvulationCalculatorCubit,
                          OvulationCalculatorState
                        >(
                          builder: (context, ovulationState) {
                            return BlocBuilder<
                              SelectCalenderCubit,
                              SelectCalenderState
                            >(
                              builder: (context, calendarState) {
                                if (calendarState is SelectCalenderValueState) {
                                  selectedDay = calendarState.selectedDay;
                                }

                                String buttonText = 'Calculate';
                                if (selectedDay == null) {
                                  buttonText = 'calculate';
                                } else if (ovulationState
                                    is OvulationCalculatorResult) {
                                  buttonText = 'Recalculate';
                                }

                                return BlocBuilder<SelectCycleCubit, String>(
                                  builder: (context, cycleState) {
                                    return CustomButton(
                                      text: buttonText,
                                      onTap:
                                          (ovulationState
                                                  is OvulationCalculatorResult)
                                              ? () {
                                                ovulationCalculatorCubit.init();
                                                selectCalenderCubit.init();
                                                selectCalenderCubit
                                                    .updateSelectedDay(
                                                      DateTime.now(),
                                                      DateTime.now(),
                                                    );
                                                selectCycleCubit.init();
                                                fertileWindow.clear();

                                                fertileStart = DateTime.now();
                                                fertileEnd = DateTime.now();
                                                ovulationDay = DateTime.now();
                                                nextPeriod = DateTime.now();
                                                pregnancyTestDay =
                                                    DateTime.now();
                                                estimatedDueDate =
                                                    DateTime.now();
                                              }
                                              : () {
                                                ovulationCalculatorCubit
                                                    .calculateOvulation(
                                                      periodStart:
                                                          selectedDay ??
                                                          DateTime.now(),
                                                      cycleLength: int.parse(
                                                        cycleState,
                                                      ),
                                                    );
                                              },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Gap(20),
                        BlocBuilder<
                          OvulationCalculatorCubit,
                          OvulationCalculatorState
                        >(
                          builder: (context, state) {
                            if (state is OvulationCalculatorResult) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OvulationCard(
                                    title: 'Fertile Window',
                                    value:
                                        '${format(state.fertileStart)} - ${format(state.fertileEnd)}',
                                    color: Color(0xFFDBEAFE),
                                  ),
                                  OvulationCard(
                                    title: 'Approximate Ovulation',
                                    value: format(state.ovulationDay),
                                    color: Color(0xFFDBFCE7),
                                  ),
                                  OvulationCard(
                                    title: 'Next Period',
                                    value: format(state.nextPeriod),
                                    color: Color(0xFFFFE2E2),
                                  ),
                                  OvulationCard(
                                    title: 'Pregnancy Test Day',
                                    value: format(state.pregnancyTestDay),
                                    color: Color(0xFFFEF9C2),
                                  ),
                                  OvulationCard(
                                    title: 'Estimated Due Date',
                                    value: format(state.estimatedDueDate),
                                    color: Color(0xFFF3E8FF),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
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
