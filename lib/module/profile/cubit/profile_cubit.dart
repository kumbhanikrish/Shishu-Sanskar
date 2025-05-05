import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() {
    if (state > 0) emit(state - 1);
  }

  init() {
    emit(0);
  }
}

class EditCubit extends Cubit<bool> {
  EditCubit() : super(false);

  void toggleVisibility() {
    emit(!state);
  }

  init() {
    emit(false);
  }
}
