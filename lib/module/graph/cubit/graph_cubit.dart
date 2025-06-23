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

  void changeTab(int index) {
    emit(GraphTabLoaded(tabIndex: index));
  }

  init() {
    emit(GraphTabLoaded(tabIndex: 0));
  }
}
