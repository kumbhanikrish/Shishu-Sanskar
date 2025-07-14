// graph_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shishu_sanskar/module/graph/cubit/graph_cubit.dart';
import 'package:shishu_sanskar/module/graph/model/daily_report_model.dart';
import 'package:shishu_sanskar/module/graph/model/graph_tab_model.dart';
import 'package:shishu_sanskar/module/graph/model/monthly_report_model.dart';
import 'package:shishu_sanskar/module/graph/model/weekly_report_model.dart';

import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/module/tools/cubit/ovulation_calculator/cubit/ovulation_calculator_cubit.dart';
import 'package:shishu_sanskar/utils/formatter/format.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_calender.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;

class GraphScreen extends StatelessWidget {
  GraphScreen({super.key});

  final List<String> tabs = const ['Daily', 'Weekly', 'Monthly'];
  int tabIndex = 0;
  List<ChartData> data = [
    ChartData(category: 'Sun', value: 60, color: AppColor.themeSecondaryColor),
    ChartData(category: 'Mon', value: 30, color: AppColor.themeSecondaryColor),
    ChartData(category: 'tue', value: 90, color: AppColor.themeSecondaryColor),
    ChartData(category: 'Wed', value: 60, color: AppColor.themeSecondaryColor),
    ChartData(category: 'Thu', value: 30, color: AppColor.themeSecondaryColor),
    ChartData(category: 'Fri', value: 90, color: AppColor.themeSecondaryColor),
    ChartData(category: 'Sat', value: 10, color: AppColor.themeSecondaryColor),
  ];
  @override
  Widget build(BuildContext context) {
    GraphTabCubit graphTabCubit = BlocProvider.of<GraphTabCubit>(context);
    GraphCubit graphCubit = BlocProvider.of<GraphCubit>(context);

    graphTabCubit.init();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<GraphTabCubit, GraphTabState>(
          builder: (context, state) {
            
            if (state is GraphTabLoaded) {
              tabIndex = state.tabIndex;
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      final isSelected = tabIndex == index;
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            graphTabCubit.changeTab(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColor.themePrimaryColor
                                      : AppColor.whiteColor,
                              borderRadius: BorderRadius.horizontal(
                                left:
                                    index == 0
                                        ? const Radius.circular(12)
                                        : Radius.zero,
                                right:
                                    index == tabs.length - 1
                                        ? const Radius.circular(12)
                                        : Radius.zero,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColor.whiteColor
                                        : AppColor.seeAllTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const Gap(30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tabIndex == 0
                            ? dailyGraph(context, graphCubit: graphCubit)
                            : tabIndex == 1
                            ? weeklyGraph(
                              context,
                              chartData: data,
                              graphCubit: graphCubit,
                            )
                            : monthlyGraph(context, graphCubit: graphCubit),

                        Gap(10.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget dailyGraph(BuildContext context, {required GraphCubit graphCubit}) {
  DailyReportModel dailyReportModel = DailyReportModel(
    data: DailyData(tasks: 0, completedTasks: 0, pendingTasks: 0),
    completedTasksList: [],
  );
  String dailyDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  graphCubit.getDailyReport(context, date: dailyDate);
  return BlocBuilder<GraphCubit, GraphState>(
    builder: (context, state) {
      if (state is GraphReportState) {
        dailyReportModel = state.dailyReportModel;
      }

      double progress =
          dailyReportModel.data.completedTasks /
          dailyReportModel.data.tasks *
          100;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.1,
                    color: AppColor.todayGrafBG,

                    thicknessUnit: gauges.GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: progress,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: AppColor.themeSecondaryColor,
                      cornerStyle: gauges.CornerStyle.bothCurve,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0,
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text:
                                dailyReportModel.data.completedTasks.toString(),
                            fontSize: 70,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 4),
                          CustomText(
                            text: 'Task: ${dailyReportModel.data.tasks}',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColor.seeAllTitleColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(10),
          CustomText(
            text: 'Completed task',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColor.seeAllTitleColor,
          ),
          Gap(10),
          dailyReportModel.completedTasksList.isEmpty
              ? CustomEmpty()
              : GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: dailyReportModel.completedTasksList.length,
                itemBuilder: (BuildContext context, int index) {
                  DailyCompletedTasksList dailyCompletedTasksList =
                      dailyReportModel.completedTasksList[index];
                  return customCardView(
                    width: 100.w,
                    height: 17.h,
                    onTap: () {},
                    image: dailyCompletedTasksList.photo ?? '',
                    title: dailyCompletedTasksList.name,
                  );
                },
              ),
        ],
      );
    },
  );
}

Widget weeklyGraph(
  BuildContext context, {
  required List<ChartData> chartData,
  required GraphCubit graphCubit,
}) {
  WeeklyReportModel weeklyReportModel = WeeklyReportModel(
    data: WeeklyData(
      tuesday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      wednesday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      thursday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      friday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      saturday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      sunday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      monday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
    ),
    completedTasksList: [],
  );
  double percent = 0.0;
  String percentLabel = "";
  graphCubit.getWeeklyReport(
    context,
    startDate: '2025-07-01',
    endDate: '2025-07-10',
  );
  return BlocBuilder<GraphCubit, GraphState>(
    builder: (context, state) {
      if (state is GraphReportState) {
        weeklyReportModel = state.weeklyReportModel;
      }

      List<DayEntry> daysList = convertToDayList(
        weeklyReportModel.data.toJson(),
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,

              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                labelStyle: const TextStyle(
                  fontFamily: 'Caros Soft',
                  fontSize: 12,
                ),
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: 0,
                maximum: 100,
                interval: 20,
                majorGridLines: MajorGridLines(
                  width: 0,
                  color: AppColor.transparentColor,
                ),
                axisLine: const AxisLine(width: 0.5),
                labelStyle: const TextStyle(
                  fontFamily: 'Caros Soft',
                  fontSize: 12,
                ),
              ),
              series: <CartesianSeries<DayEntry, String>>[
                ColumnSeries<DayEntry, String>(
                  dataSource: daysList,
                  xValueMapper: (DayEntry data, _) => data.dayName,
                  yValueMapper: (DayEntry data, _) {
                    final int total = data.data.tasks;
                    final int completed = data.data.completedTasks;

                    if (total > 0) {
                      percent = completed / total;
                      percentLabel = "${(percent * 100).toStringAsFixed(0)}%";
                    } else {
                      percent = 0.0;
                      percentLabel = "0%";
                    }

                    return data.data.completedTasks;
                  },
                  pointColorMapper:
                      (DayEntry data, _) => AppColor.themeSecondaryColor,
                  dataLabelMapper: (DayEntry data, _) {
                    final int total = data.data.tasks;
                    final int completed = data.data.completedTasks;

                    if (total > 0) {
                      percent = completed / total;
                      percentLabel = "${(percent * 100).toStringAsFixed(0)}%";
                    } else {
                      percent = 0.0;
                      percentLabel = "0%";
                    }

                    return percentLabel;
                  },
                  width: 0.6,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontFamily: 'Caros Soft',
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(10),

          CustomText(
            text: 'Completed task',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColor.seeAllTitleColor,
          ),
          Gap(10),
          weeklyReportModel.completedTasksList.isEmpty
              ? CustomEmpty()
              : GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: weeklyReportModel.completedTasksList.length,
                itemBuilder: (BuildContext context, int index) {
                  WeeklyCompletedTasksList weeklyCompletedTasksList =
                      weeklyReportModel.completedTasksList[index];
                  return customCardView(
                    width: 100.w,
                    height: 17.h,
                    onTap: () {},
                    image: weeklyCompletedTasksList.photo ?? '',
                    title: weeklyCompletedTasksList.name,
                  );
                },
              ),
        ],
      );
    },
  );
}

Widget monthlyGraph(BuildContext context, {required GraphCubit graphCubit}) {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  MonthlyReportModel monthlyReportModel = MonthlyReportModel(
    data: {},
    completedTasksList: [],
  );

  final String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  graphCubit.getMonthlyReport(context, month: currentMonth);
  final selectCalenderCubit = BlocProvider.of<SelectCalenderCubit>(context);
  selectCalenderCubit.init();
  selectCalenderCubit.updateSelectedDay(DateTime.now(), DateTime.now());

  return BlocBuilder<SelectCalenderCubit, SelectCalenderState>(
    builder: (context, state) {
      if (state is SelectCalenderValueState) {
        focusedDay = state.focusedDay;
        selectedDay = state.selectedDay;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomCalender(
              focusedDay: focusedDay,
              selectedDay: selectedDay,
              headerColor: AppColor.weeklyGrafBG,
              onPageChanged: (focusedDay) {
                graphCubit.getMonthlyReport(
                  context,
                  month: DateFormat('yyyy-MM').format(focusedDay),
                );
              },
              selectedDayPredicate: (_) => false,
              onDaySelected: (_, __) {},

              defaultBuilder: (context, day, focusedDay) {
                return BlocBuilder<GraphCubit, GraphState>(
                  builder: (context, state) {
                    double percent = 0.0;
                    String percentLabel = "";

                    if (state is GraphReportState) {
                      monthlyReportModel = state.monthlyReportModel;

                      // Format the date to match the key format in your data map
                      final String formattedDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(day);
                      if (monthlyReportModel.data.containsKey(formattedDate)) {
                        final dayData = monthlyReportModel.data[formattedDate];

                        if (dayData != null) {
                          final int total = dayData.tasks;
                          final int completed = dayData.completedTasks;

                          if (total > 0) {
                            percent = completed / total;
                            percentLabel =
                                "${(percent * 100).toStringAsFixed(0)}%";
                          } else {
                            percent = 0.0;
                            percentLabel = "0%";
                          }
                        }
                      }
                    }

                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularPercentIndicator(
                        radius: 18,
                        lineWidth: 3,
                        percent: percent.clamp(
                          0.0,
                          1.0,
                        ), // Ensure between 0.0 - 1.0
                        animation: true,
                        backgroundColor: AppColor.todayGrafBG,
                        progressColor: AppColor.themeSecondaryColor,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: '${day.day}',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text: percentLabel,
                              fontSize: 6,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Gap(10),

          CustomText(
            text: 'Completed task',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColor.seeAllTitleColor,
          ),
          Gap(10),
          BlocBuilder<GraphCubit, GraphState>(
            builder: (context, state) {
              if (state is GraphReportState) {
                monthlyReportModel = state.monthlyReportModel;
              }
              return monthlyReportModel.completedTasksList.isEmpty
                  ? CustomEmpty()
                  : GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: monthlyReportModel.completedTasksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      MonthlyCompletedTasksList monthlyCompletedTasksList =
                          monthlyReportModel.completedTasksList[index];
                      return customCardView(
                        width: 100.w,
                        height: 17.h,
                        onTap: () {},
                        image: monthlyCompletedTasksList.photo ?? '',
                        title: monthlyCompletedTasksList.name,
                      );
                    },
                  );
            },
          ),
        ],
      );
    },
  );
}
