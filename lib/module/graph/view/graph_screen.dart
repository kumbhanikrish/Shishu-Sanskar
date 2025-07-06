// graph_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shishu_sanskar/module/graph/cubit/graph_cubit.dart';
import 'package:shishu_sanskar/module/graph/model/graph_tab_model.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/module/tools/cubit/ovulation_calculator/cubit/ovulation_calculator_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_calender.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauges;
import 'package:table_calendar/table_calendar.dart';

class GraphScreen extends StatelessWidget {
  GraphScreen({super.key});

  final List<String> tabs = const ['Today', 'Daily', 'Weekly'];
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
    final int totalTasks = 30;
    final int completedTasks = 20;
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
                            ? todayGraph(
                              completedTasks: completedTasks,
                              totalTasks: totalTasks,
                            )
                            : tabIndex == 1
                            ? dailyGraph(chartData: data)
                            : weeklyGraph(context),

                        CustomText(
                          text: 'Completed task',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColor.seeAllTitleColor,
                        ),
                        Gap(10),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: 8,
                          itemBuilder: (BuildContext context, int index) {
                            return customCardView(
                              width: 100.w,
                              height: 17.h,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppPage.taskDetailScreen,
                                );
                              },
                              image:
                                  'https://bookyogatraining.com/wp-content/uploads/2022/09/Yoga-for-Women-1.jpg',
                              title: 'Affirmations',
                            );
                          },
                        ),

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

Widget todayGraph({required int completedTasks, required int totalTasks}) {
  double progress = completedTasks / totalTasks * 100;

  return SizedBox(
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
                    text: completedTasks.toString(),
                    fontSize: 70,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    text: 'Task: $totalTasks',
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
  );
}

Widget dailyGraph({required List<ChartData> chartData}) {
  return SizedBox(
    height: 250,
    child: SfCartesianChart(
      plotAreaBorderWidth: 0,

      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(fontFamily: 'Caros Soft', fontSize: 12),
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
        labelStyle: const TextStyle(fontFamily: 'Caros Soft', fontSize: 12),
      ),
      series: <CartesianSeries<ChartData, String>>[
        ColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelMapper: (ChartData data, _) => '${data.value}%',
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
  );
}

Widget weeklyGraph(BuildContext context) {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final selectCalenderCubit = BlocProvider.of<SelectCalenderCubit>(context);
  selectCalenderCubit.init();
  selectCalenderCubit.updateSelectedDay(DateTime.now(), DateTime.now());

  return BlocBuilder<SelectCalenderCubit, SelectCalenderState>(
    builder: (context, state) {
      if (state is SelectCalenderValueState) {
        focusedDay = state.focusedDay;
        selectedDay = state.selectedDay;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CustomCalender(
          focusedDay: focusedDay,
          selectedDay: selectedDay,
          headerColor: AppColor.weeklyGrafBG,
          // Day selection is disabled for week-only view
          selectedDayPredicate: (_) => false,
          onDaySelected: (_, __) {},

          defaultBuilder: (context, day, focusedDay) {
            final isToday = isSameDay(day, DateTime.now());

            return SizedBox(
              width: 50,
              height: 50,
              child: CircularPercentIndicator(
                radius: 18,
                lineWidth: 3,
                percent: 0.5,
                animation: true,
                backgroundColor: AppColor.todayGrafBG,
                progressColor:
                    isToday
                        ? Colors
                            .red // Or AppColor.todayColor
                        : AppColor.themeSecondaryColor,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: '${day.day}',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: '50%',
                      fontSize: 6,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
