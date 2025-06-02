import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(2);

  void changeTab(int index) {
    emit(index);
  }
  init() {
    emit(2); // Default to Home tab
  }
}
