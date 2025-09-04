import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shishu_sanskar/all_state_init.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/model/auth_category_model.dart';
import 'package:shishu_sanskar/module/auth/model/languages_model.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/module/auth/repo/auth_repo.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/formatter/format.dart';

part 'auth_state.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthRepo authRepo = AuthRepo();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<Response> login(
    BuildContext context, {
    required String email,
    required String password,
    required String socialType,
    required String socialToken,
    String? firstName,
    String? middleName,
    String? lastName,
  }) async {
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String deviceName = await getDeviceName();
    String version = packageInfo.version;
    Map<String, dynamic> loginParams = {
      "email": email,
      "password": password,
      "fcm_token": token,
      "device_name": deviceName,
      "device_os": Platform.isAndroid ? 'Android' : 'IOS',
      "app_version": version,
    };

    if (socialType == 'google') {
      Map<String, dynamic> googleParams = {
        "social_type": socialType,
        "social_token": socialToken,
      };
      loginParams.addAll(googleParams);
    }

    final Response response = await authRepo.login(
      context,
      params: loginParams,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
    );

    if (response.data['success'] == true) {
      LoginModel loginModel = LoginModel.fromJson(response.data['data']);
      await localDataSaver.setAuthToken(loginModel.token);
      await localDataSaver.setCategoryId(loginModel.user.categoryId);
      await localDataSaver.setPlanId(
        loginModel.user.currentSubscription.planId,
      );
      await localDataSaver.setUserUniqueId(loginModel.user.userUniqueId);

      await localDataSaver.setLmpDate(loginModel.user.lmp ?? '');
      await localDataSaver.setCategoryName(loginModel.user.categoryName);
      await localDataSaver.setLoginData(loginModel);
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
    required int languageId,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required String lmp,
    required String googleToken,
    required String appleToken,
  }) async {
    String? token = await messaging.getToken();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String deviceName = await getDeviceName();
    String version = packageInfo.version;
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
      "device_name": deviceName,
      "device_os": Platform.isAndroid ? 'Android' : 'IOS',
      "app_version": version,
      "fcm_token": token,
      "language_id": languageId,
      'location': await getCityName(),
      if (googleToken.isNotEmpty) "google_token": googleToken,
      if (appleToken.isNotEmpty) "apple_token": appleToken,
    };

    Response response = await authRepo.register(
      context,
      params: registerParams,
    );

    if (response.data['success'] == true) {
      LoginModel loginModel = LoginModel.fromJson(response.data['data']);
      await localDataSaver.setAuthToken(loginModel.token);
      await localDataSaver.setCategoryId(loginModel.user.categoryId);
      await localDataSaver.setPlanId(
        loginModel.user.currentSubscription.planId,
      );
      await localDataSaver.setUserUniqueId(loginModel.user.userUniqueId);

      await localDataSaver.setLmpDate(loginModel.user.lmp ?? '');
      await localDataSaver.setCategoryName(loginModel.user.categoryName);
      await localDataSaver.setLoginData(loginModel);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.bottomNavigationScreen,
        (route) => false,
      );
    }
    return response;
  }

  Future<Response> sendOtp(
    BuildContext context, {
    required String mobile,
    required PasswordVisibilityCubit passwordVisibilityCubit,
    required bool resend,
  }) async {
    Map<String, dynamic> sendOtpParams = {"mobile": mobile};

    Response response = await authRepo.sendOtp(context, params: sendOtpParams);

    if (response.data['success'] == true) {
      await localDataSaver.setVerificationId(
        response.data['data'].isNotEmpty ? response.data['data'] : '',
      );
      if (!resend) {
        passwordVisibilityCubit.toggleVisibility();
      }
    }

    return response;
  }

  Future<Response> logout(BuildContext context) async {
    LoginModel loginModel = await localDataSaver.getLoginModel();

    if (loginModel.user.googleToken.isNotEmpty) {
      handleGoogleSignOut(context);
    }
    Response response = await authRepo.logout(context, params: {});

    if (response.data['success'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.loginScreen,
        (route) => false,
      );
      await localDataSaver.setAuthToken('');

      allStateInit(context);
    }

    return response;
  }

  Future<Response> deleteAccount(
    BuildContext context, {
    required String password,
    required List<String> reasons,
    required String feedback,
  }) async {
    Map<String, dynamic> params = {
      "password": password,
      "reasons": reasons,
      "feedback": feedback,
    };
    Response response = await authRepo.deleteAccount(context, params: params);

    if (response.data['success'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.loginScreen,
        (route) => false,
      );
      await localDataSaver.setAuthToken('');
    }

    return response;
  }

  Future<Response> forgotPassword(
    BuildContext context, {
    required String email,
    bool resend = false,
    required StepperCubit stepperCubit,
  }) async {
    Map<String, dynamic> sendOtpParams = {"email": email};

    Response response = await authRepo.forgotPassword(
      context,
      params: sendOtpParams,
    );

    if (response.data['success'] == true) {
      if (resend == false) {
        stepperCubit.nextStep(step: 1);
      }
    }

    return response;
  }

  Future<Response> resetPassword(
    BuildContext context, {

    required StepperCubit stepperCubit,
    String passwordConfirmation = "",

    String newPassword = "",
    String email = "",
  }) async {
    Map<String, dynamic> sendOtpParams = {
      'email': email,
      "password": newPassword,
      "password_confirmation": passwordConfirmation,
    };

    Response response = await authRepo.resetPassword(
      context,
      params: sendOtpParams,
    );

    if (response.data['success'] == true) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.loginScreen,
        (route) => false,
      );
    }

    return response;
  }

  Future<Response> forgotOtpVerify(
    BuildContext context, {

    required StepperCubit stepperCubit,
    String otp = "",

    String email = "",
  }) async {
    Map<String, dynamic> sendOtpParams = {"email": email, "otp": otp};

    Response response = await authRepo.forgotOtpVerify(
      context,
      params: sendOtpParams,
    );

    if (response.data['success'] == true) {
      stepperCubit.nextStep(step: 2);
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
    required StepperCubit stepperCubit,
    required VerifiedNumber verifiedNumber,
    required VerifiedWNumber verifiedWNumber,
  }) async {
    String verificationId = await dataSaver.getVerificationId();
    Map<String, dynamic> sendOtpParams = {
      "otp": opt,
      'mobile': mobile,
      'verificationId': verificationId,
    };

    Response response = await authRepo.verifyOtp(
      context,
      params: sendOtpParams,
    );

    if (response.data['success'] == true) {
      stepperCubit.nextStep(step: 2);

      if (number == false) {
        verifiedNumber.verifiedNumber(number);
      } else if (wNumber == false) {
        verifiedWNumber.verifiedWNumber(wNumber);
      }
    }

    return response;
  }

  Future authCategory(BuildContext context) async {
    List<AuthCategoryModel> authCategoryList = [];

    Response response = await authRepo.authCategory(context);
    if (response.data['success'] == true) {
      authCategoryList =
          (response.data['data'] as List)
              .map((e) => AuthCategoryModel.fromJson(e))
              .toList();
    }

    emit(AuthCategoryState(authCategoryList: authCategoryList));
  }

  Future languages(BuildContext context) async {
    List<LanguagesModel> languagesList = [];

    Response response = await authRepo.languages(context);
    if (response.data['success'] == true) {
      languagesList =
          (response.data['data'] as List)
              .map((e) => LanguagesModel.fromJson(e))
              .toList();
    }

    emit(LanguagesState(languagesList: languagesList));
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    // Step 1: Start Google Sign-In
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      log("Google sign-in aborted by user");
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final String? accessToken = googleAuth.accessToken;
    final String? idToken = googleAuth.idToken;
    final String email = googleUser.email;
    final String? displayName = googleUser.displayName;

    log("Access Token: $accessToken");
    log("ID Token: $idToken");
    log("Email: $email");
    log("Display Name: $displayName");

    // Step 2: Extract First, Middle, and Last Name
    String firstName = '';
    String middleName = '';
    String lastName = '';

    if (displayName != null && displayName.isNotEmpty) {
      final nameParts = displayName.trim().split(' ');

      if (nameParts.length == 1) {
        firstName = nameParts[0];
      } else if (nameParts.length == 2) {
        firstName = nameParts[0];
        lastName = nameParts[1];
      } else if (nameParts.length >= 3) {
        firstName = nameParts[0];
        middleName = nameParts.sublist(1, nameParts.length - 1).join(' ');
        lastName = nameParts.last;
      }
    }

    log("First Name: $firstName");
    log("Middle Name: $middleName");
    log("Last Name: $lastName");

    // Step 3: Call your custom API
    if (accessToken != null) {
      await login(
        context,
        email: email,
        password: '',
        socialType: 'google',
        socialToken: accessToken,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
      );

      // Step 4: Firebase sign-in
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        log("Firebase sign-in successful for ${user.email}");
        // Continue your flow
      } else {
        log("Firebase user is null");
      }
    }
  }

  Future<void> handleGoogleSignOut(BuildContext context) async {
    await googleSignIn.signOut();
    await localDataSaver.setAuthToken('');
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppPage.loginScreen,
      (route) => false,
    );
  }

  init() {
    emit(AuthInitial());
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

class LanguagesRadioCubit extends Cubit<int> {
  LanguagesRadioCubit() : super(-1);

  void selectLanguages(int category) {
    log('typetype ::$category');
    emit(category);
  }

  init() {
    emit(-1);
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

class ReasonCubit extends Cubit<List<String>> {
  ReasonCubit() : super([]);

  void toggleReason(String reason) {
    if (state.contains(reason)) {
      emit(List.from(state)..remove(reason));
    } else {
      emit(List.from(state)..add(reason));
    }
  }

  void clearSelection() {
    emit([]);
  }
}

class DatePickerCubit extends Cubit<DateTime?> {
  DatePickerCubit() : super(null);

  void selectDate(BuildContext context, DateTime? date) {
    if (date != null) {
      emit(date);
      Navigator.pop(context);
    }
  }

  init() {
    emit(null);
  }
}

class DatePicker2Cubit extends Cubit<DateTime?> {
  DatePicker2Cubit() : super(null);

  void selectDate(BuildContext context, DateTime? date) {
    if (date != null) {
      emit(date);
      Navigator.pop(context);
    }
  }

  init() {
    emit(null);
  }
}
