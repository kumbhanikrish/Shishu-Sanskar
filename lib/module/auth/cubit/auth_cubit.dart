import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/repo/auth_repo.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepo authRepo = AuthRepo();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<Response> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    Map<String, dynamic> loginParams = {
      "email": email,
      "password": password,
      "fcm_token": token,
    };

    final Response response = await authRepo.login(
      context,
      params: loginParams,
    );

    if (response.data['success'] == true) {
      await localDataSaver.setAuthToken(response.data['data']['token'] ?? '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.bottomNavigationScreen,
        (route) => false,
      );
    }
    return response;
  }

  Future<Response> register(
    BuildContext context, {
    required String firstName,
    required String middleName,
    required String lastName,
    required String contactNumber,
    required String whatsappNumber,
    required int categoryId,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required String lmp,
  }) async {
    Map<String, dynamic> registerParams = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "contact_number": contactNumber,
      "whatsapp_number": whatsappNumber,
      "category_id": categoryId,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "gender": gender,
      "lmp": lmp,
    };

    Response response = await authRepo.register(
      context,
      params: registerParams,
    );

    if (response.data['success'] == true) {
      await localDataSaver.setAuthToken(response.data['data']['token'] ?? '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.loginScreen,
        (route) => false,
      );
    }
    return response;
  }

  Future<Response> sendOtp(
    BuildContext context, {
    required String mobile,
    required PasswordVisibilityCubit passwordVisibilityCubit,
  }) async {
    Map<String, dynamic> sendOtpParams = {"mobile": mobile};

    Response response = await authRepo.sendOtp(context, params: sendOtpParams);

    if (response.data['success'] == true) {
      passwordVisibilityCubit.toggleVisibility();
    }

    return response;
  }

  Future<Response> verifyOtp(
    BuildContext context, {
    required String opt,
    required String mobile,
    required bool number,
    required bool wNumber,

    required PasswordVisibilityCubit passwordVisibilityCubit,
    required VerifiedNumber verifiedNumber,
    required VerifiedWNumber verifiedWNumber,
  }) async {
    Map<String, dynamic> sendOtpParams = {"otp": opt, 'mobile': mobile};

    Response response = await authRepo.verifyOtp(
      context,
      params: sendOtpParams,
    );

    if (response.data['success'] == true) {
      passwordVisibilityCubit.toggleVisibility();

      if (number == false) {
        verifiedNumber.verifiedNumber(number);
      } else if (wNumber == false) {
        verifiedWNumber.verifiedWNumber(wNumber);
      }
    }

    return response;
  }
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

class CategoryRadioCubit extends Cubit<int> {
  CategoryRadioCubit() : super(0);

  void selectCategory(int category) {
    log('typetype ::$category');
    emit(category);
  }

  init() {
    emit(0);
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

class VerifiedNumber extends Cubit<bool> {
  VerifiedNumber() : super(false);

  void verifiedNumber(bool number) {
    emit(!number);
  }

  init() {
    emit(false);
  }
}

class VerifiedWNumber extends Cubit<bool> {
  VerifiedWNumber() : super(false);

  void verifiedWNumber(bool number) {
    emit(!number);
  }

  init() {
    emit(false);
  }
}
