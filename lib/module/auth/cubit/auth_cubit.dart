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

  void nextStep({required int step}) {
    log('step ::$step');
    emit(step);
  }

  void previousStep({required int step}) {
    emit(step);
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

  init() {
    emit(UserType.female);
  }
}

class MaritalRadioCubit extends Cubit<MaritalType> {
  MaritalRadioCubit() : super(MaritalType.married);

  void selectMaritalType(MaritalType type) {
    log('typetype ::$type');
    emit(type);
  }

  init() {
    emit(MaritalType.married);
  }
}

class CategoryRadioCubit extends Cubit<String> {
  CategoryRadioCubit() : super('');

  void selectCategory(String category) {
    log('typetype ::$category');
    emit(category);
  }

  init() {
    emit('');
  }
}

class StoreNumberCubit extends Cubit<StoreNumberState> {
  StoreNumberCubit() : super(StoreNumberInitial());

  selectNumberCountry({required String flag, required String code}) {
    emit(StoreNumberLoaded(code, flag: flag));
  }

  init() {
    emit(StoreNumberInitial());
  }
}

class StoreWpNumberCubit extends Cubit<StoreWpNumberState> {
  StoreWpNumberCubit() : super(StoreWpNumberInitial());

  selectWpNumberCountry({required String flag, required String code}) {
    emit(StoreWpNumberLoaded(code, flag: flag));
  }

  init() {
    emit(StoreWpNumberInitial());
  }
}
