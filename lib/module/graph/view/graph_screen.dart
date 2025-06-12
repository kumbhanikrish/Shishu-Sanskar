// graph_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shishu_sanskar/module/graph/cubit/graph_cubit.dart';
import 'package:shishu_sanskar/module/graph/model/graph_tab_model.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_list_tile.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {
  GraphScreen({super.key});

  final List<String> tabs = const ['All', 'Today', 'Daily', 'Weekly'];
  int tabIndex = 0;
  List<ChartData> data = [];
  @override
  Widget build(BuildContext context) {
    GraphTabCubit graphTabCubit = BlocProvider.of<GraphTabCubit>(context);
    graphTabCubit.init();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<GraphTabCubit, GraphTabState>(
          builder: (context, state) {
            if (state is GraphTabLoaded) {
              tabIndex = state.tabIndex;
              data = state.data;
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
                SizedBox(
                  height: 250,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,

                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(width: 0.5),
                      labelStyle: const TextStyle(
                        fontFamily: 'Caros Soft',
                        fontSize: 12,
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 100,
                      interval: 20,
                      majorGridLines: MajorGridLines(
                        width: 1,
                        color: AppColor.graphBorderColor,
                      ),
                      axisLine: const AxisLine(width: 0.5),
                      labelStyle: const TextStyle(
                        fontFamily: 'Caros Soft',
                        fontSize: 12,
                      ),
                    ),
                    series: <CartesianSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        dataSource: data,
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.value,
                        pointColorMapper: (ChartData data, _) => data.color,
                        dataLabelMapper:
                            (ChartData data, _) => '${data.value}%',
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
                CustomListTile(
                  text: 'Overall Status',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  leadingImage: '',
                  trailing: CustomText(
                    text: '80%',
                    color: AppColor.themeSecondaryColor,
                    fontSize: 12,
                  ),
                ),
                Gap(10),
                LinearPercentIndicator(
                  animation: true,
                  padding: EdgeInsets.zero,
                  barRadius: Radius.circular(12),
                  width: 89.5.w,
                  lineHeight: 7,
                  percent: 0.8,
                  backgroundColor: AppColor.overallStatusBgColor,
                  progressColor: AppColor.themePrimaryColor,
                ),
                Gap(10),

                CustomListTile(
                  text: 'Today Task',
                  fontSize: 12,

                  leadingImage: '',
                  trailing: CustomText(text: '40%', fontSize: 12),
                ),

                CustomListTile(
                  text: 'Daily Task',
                  fontSize: 12,

                  leadingImage: '',
                  trailing: CustomText(text: '30%', fontSize: 12),
                ),

                CustomListTile(
                  text: 'Weekly Task',
                  fontSize: 12,

                  leadingImage: '',
                  trailing: CustomText(text: '10%', fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
