import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class PricingRepo {
  Future<Response> getPlans(
    BuildContext context, {
    required String categoryId,
  }) async {
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.plans}$categoryId',
    );

    return response;
  }

  Future<Response> payment(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      AppApi.payment,
      params,
      showSuccessMessage: true,
    );

    return response;
  }
}
