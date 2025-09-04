import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';

class LocalDataSaver {
  Future clearAllData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    log("All local data cleared successfully.");
    await sharedPreference.clear();
  }

  Future setAuthToken(String authToken) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('authToken', authToken);
  }

  Future<String> getAuthToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('authToken') ?? '';
  }

  Future setCategoryId(int categoryId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setInt('categoryId', categoryId);
  }

  Future<int> getCategoryId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getInt('categoryId') ?? 0;
  }

  Future setPlanId(int planId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setInt('planId', planId);
  }

  Future<int> getPlanId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getInt('planId') ?? 0;
  }

  Future setUserUniqueId(String userUniqueId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('userUniqueId', userUniqueId);
  }

  Future<String> getUserUniqueId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('userUniqueId') ?? '';
  }

  Future setLmpDate(String lmpDate) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('lmpDate', lmpDate);
  }

  Future<String> getLmpDate() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('lmpDate') ?? '';
  }

  Future setCategoryName(String categoryName) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('categoryName', categoryName);
  }

  Future<String> getCategoryName() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('categoryName') ?? '';
  }

  Future setNotificationsEnabled(bool value) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool('notifications_enabled', value);
  }

  Future<bool> getNotificationsEnabled() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getBool('notifications_enabled') ?? true;
  }

  Future setVerificationId(String verificationId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('verificationId', verificationId);
  }

  Future<String> getVerificationId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('verificationId') ?? '';
  }

  // ✅ Save LoginModel as JSON string
  Future<void> setLoginData(LoginModel loginModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(loginModel.toJson());
    await sharedPreferences.setString('login_data', jsonString);
    log("LoginModel saved.");
  }

  // ✅ Get LoginModel from storage
  Future<LoginModel> getLoginModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('login_data');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return LoginModel.fromJson(jsonMap);
    }
    throw Exception("LoginModel not found");
  }
}
