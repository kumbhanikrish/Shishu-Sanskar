import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shishu_sanskar/module/graph/model/graph_tab_model.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphInitial());
}

class GraphTabCubit extends Cubit<GraphTabState> {
  GraphTabCubit() : super(GraphTabInitial());

  static List<ChartData> _getChartData(int index) {
    switch (index) {
      case 1:
        return [
          ChartData(
            category: 'Today',
            value: 60,
            color: AppColor.themePrimaryColor2,
          ),
        ];
      case 2:
        return [
          ChartData(
            category: 'Daily',
            value: 30,
            color: AppColor.themeSecondaryColor,
          ),
        ];
      case 3:
        return [
          ChartData(
            category: 'Weekly',
            value: 90,
            color: AppColor.themePrimaryColor,
          ),
        ];
      default:
        return [
          ChartData(
            category: 'Today',
            value: 60,
            color: AppColor.themePrimaryColor2,
          ),
          ChartData(
            category: 'Daily',
            value: 30,
            color: AppColor.themeSecondaryColor,
          ),
          ChartData(
            category: 'Weekly',
            value: 90,
            color: AppColor.themePrimaryColor,
          ),
        ];
    }
  }

  void changeTab(int index) {
    emit(GraphTabLoaded(tabIndex: index, data: _getChartData(index)));
  }

  init() {
    emit(GraphTabLoaded(tabIndex: 0, data: _getChartData(0)));
  }
}
