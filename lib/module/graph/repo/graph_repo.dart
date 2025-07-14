import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class GraphRepo {
  Future<Response> getReport(
    BuildContext context, {
    required String type,
    required Map<String, dynamic> params,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      '${AppApi.report}$type',
      params,
    );

    return response;
  }
}
