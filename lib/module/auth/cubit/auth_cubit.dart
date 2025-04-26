import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}

class StepperCubit extends Cubit<int> {
  StepperCubit() : super(0);

  void nextStep() {
    if (state < 2) emit(state + 1);
  }

  void previousStep() {
    if (state > 0) emit(state - 1);
  }

  void init() {
    emit(0);
  }
}

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }

  init() {
    emit(true);
  }
}

class CPasswordVisibilityCubit extends Cubit<bool> {
  CPasswordVisibilityCubit() : super(true);
  void toggleVisibility() {
    emit(!state);
  }

  init() {
    emit(true);
  }
}

class RadioCubit extends Cubit<UserType> {
  RadioCubit() : super(UserType.female);

  void selectUserType(UserType type) {
    log('typetype ::$type');
    emit(type);
  }
}
