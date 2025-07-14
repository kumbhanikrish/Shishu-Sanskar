import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class ProfileRepo {
  Future<Response> editProfile(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.editProfile,
      showSuccessMessage: true,
      params,
      isFormData: true,
    );

    return response;
  }

  Future<Response> getUser(BuildContext context) async {
    LoginModel loginModel = await localDataSaver.getLoginModel();
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.user}${loginModel.user.id}',
    );

    return response;
  }

  Future<Response> editUserLanguage(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.editUserLanguage,
      params,
    );

    return response;
  }
}
