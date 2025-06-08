import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/services/api_services.dart';
import 'package:shishu_sanskar/utils/constant/app_api.dart';

class BlogsRepo {
  Future<Response> getBlogs(
    BuildContext context, {
    required String search,
    required String page,
  }) async {
    Response response = await apiServices.getDynamicData(
      context,
      '${AppApi.blogList}$search&page=$page',
    );

    return response;
  }
}
