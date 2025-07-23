import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/module/pricing/model/pricing_model.dart';
import 'package:shishu_sanskar/module/pricing/view/widget/custom_pricing_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  List<PricingModel> pricingList = [];
  Future<void> onRefresh() async {
    int categoryId = await localDataSaver.getCategoryId();
    await context.read<PricingCubit>().getPlans(
      context,
      categoryId: categoryId.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Gap(20),
                  CustomText(
                    text: "Shishu sanskar's Flexible, Affordable Pricing",
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                  ),
                  Gap(30),
                  BlocBuilder<PricingCubit, PricingState>(
                    builder: (context, state) {
                      if (state is GetPricingState) {
                        pricingList = state.pricingList;
                      }
                      return Expanded(
                        child:
                            pricingList.isEmpty
                                ? CustomEmpty()
                                : FutureBuilder(
                                  future: planId(),
                                  builder: (context, planId) {
                                    return RefreshIndicator(
                                      backgroundColor: AppColor.whiteColor,
                                      color: AppColor.themePrimaryColor,
                                      elevation: 0,
                                      onRefresh: onRefresh,
                                      child: ListView.separated(
                                        physics:
                                            AlwaysScrollableScrollPhysics(),

                                        itemCount: pricingList.length,
                                        separatorBuilder: (_, __) => Gap(20),
                                        itemBuilder: (_, index) {
                                          PricingModel pricingModel =
                                              pricingList[index];

                                          final isActivePlan =
                                              pricingModel.id == planId.data;

                                          return customPricingCard(
                                            buttonText:
                                                isActivePlan
                                                    ? 'Active'
                                                    : 'Choose Plan',
                                            image:
                                                pricingModel.title == 'Online'
                                                    ? AppImage.online
                                                    : AppImage.offline,
                                            name: pricingModel.title,
                                            price: '₹${pricingModel.price}',
                                            onTap:
                                                isActivePlan
                                                    ? () {
                                                      customInfoToast(
                                                        context,
                                                        text:
                                                            '${pricingModel.title} this plan is active',
                                                      );
                                                    }
                                                    : () {
                                                      // selectedPricingModel = model;
                                                      // openCheckout(model);
                                                      Navigator.pushNamed(
                                                        context,
                                                        AppPage.payDetailScreen,

                                                        arguments: {
                                                          'pricingModel':
                                                              pricingModel,
                                                        },
                                                      );
                                                    },
                                            backgroundColor:
                                                AppColor.themePrimaryColor,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  pricingModel.services.length,
                                              itemBuilder: (_, i) {
                                                return customDoneIconAndText(
                                                  text:
                                                      pricingModel.services[i],
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 20.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.whiteColor.withOpacity(0),
                          AppColor.whiteColor.withOpacity(0.95),
                          AppColor.whiteColor.withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
