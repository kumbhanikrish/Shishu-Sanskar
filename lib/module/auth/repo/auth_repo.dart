import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class AuthRepo {
  Future<Response> login(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.login,
      params,
    );

    return response;
  }

  Future<Response> register(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.register,
      params,
    );

    return response;
  }

  Future<Response> sendOtp(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.sendOtp,
      params,
    );

    return response;
  }

  Future<Response> verifyOtp(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.verifyOtp,
      params,
    );

    return response;
  }
}
