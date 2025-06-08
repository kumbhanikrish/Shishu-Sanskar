import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/pricing/model/pricing_model.dart';
import 'package:shishu_sanskar/module/pricing/repo/pricing_repo.dart';

part 'pricing_state.dart';

class PricingCubit extends Cubit<PricingState> {
  PricingCubit() : super(PricingInitial());

  PricingRepo pricingRepo = PricingRepo();
  List<PricingModel> pricingList = [];
  Future<Response> getPlans(
    BuildContext context, {
    required String categoryId,
  }) async {
    Response response = await pricingRepo.getPlans(
      context,
      categoryId: categoryId,
    );

    if (response.data['success'] == true && response.data != null) {
      log('successv');

      pricingList =
          (response.data['data'] as List)
              .map((e) => PricingModel.fromJson(e))
              .toList();
    } else {
      log('response.data is null or success == false');
    }
    emit(GetPricingState(pricingList: pricingList));
    return response;
  }
}
