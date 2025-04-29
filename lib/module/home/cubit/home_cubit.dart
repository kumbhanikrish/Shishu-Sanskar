import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  void changeTab(int index) {
    emit(index);
  }
}
