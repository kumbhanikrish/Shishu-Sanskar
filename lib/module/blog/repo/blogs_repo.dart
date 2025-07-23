import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class BlogsRepo {
  Future<Response> getBlogs(
    BuildContext context, {
    required String search,
    required String page,
  }) async {
    int categoryId = await localDataSaver.getCategoryId();

    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.blogList}$search&page=$page&category_id=$categoryId',
    );

    return response;
  }
}
