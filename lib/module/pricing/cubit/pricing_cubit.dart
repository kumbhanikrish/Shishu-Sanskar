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

    if (response.data['success'] == true) {
      log('success');

      pricingList =
          (response.data['data'] as List)
              .map((e) => PricingModel.fromJson(e))
              .toList();
      emit(GetPricingState(pricingList: pricingList));
    } else {
      emit(GetPricingState(pricingList: []));
    }
    return response;
  }

  Future<Response> payment(
    BuildContext context, {
    required Map<String, dynamic> params,
  }) async {
    Response response = await pricingRepo.payment(context, params: params);

    if (response.data['success'] == true && response.data != null) {}
    return response;
  }

  void init() {
    emit(GetPricingState(pricingList: []));
  }
}
