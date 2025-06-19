import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class HomeRepo {
  Future<Response> getEvent(
    BuildContext context, {
    required String page,
  }) async {
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.getEvent}$page',
    );

    return response;
  }
}
