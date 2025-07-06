import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
