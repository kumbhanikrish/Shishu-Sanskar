import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class HomeRepo {
  Future<Response> getEvent(
    BuildContext context, {
    required String page,
  }) async {
    int categoryId = await localDataSaver.getCategoryId();
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.getEvent}$page&category_id=$categoryId',
      showLoading: false,
    );

    return response;
  }

  Future<Response> joinEvent(
    BuildContext context, {
    required int eventId,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      '${AppApi.joinEvent}$eventId/join',
      {},
      showSuccessMessage: true,
    );

    return response;
  }

  Future<Response> getTasks(BuildContext context) async {
    int categoryId = await localDataSaver.getCategoryId();
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.userTasks}?category_id=$categoryId',
      showLoading: false,
    );

    return response;
  }

  Future<Response> completeTask(
    BuildContext context, {
    required int taskId,
  }) async {
    Response response = await apiServices.postDynamicData(
      context,
      '${AppApi.userTasks}/$taskId/complete',
      {},
      showSuccessMessage: true,
    );

    return response;
  }
}
