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
      showSuccessMessage: true,
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
      showSuccessMessage: true,
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
      showSuccessMessage: true,

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
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> forgotPassword(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.forgotPassword,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> resetPassword(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.resetPassword,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> forgotOtpVerify(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.forgotOtpVerify,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> logout(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.logout,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> deleteAccount(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.deleteAccount,
      showSuccessMessage: true,

      params,
    );

    return response;
  }

  Future<Response> authCategory(
    BuildContext context, ) async {
    Response response = await apiServices.getDynamicData(
      context,
      AppApi.authCategory,
    );

    return response;
  }
}
