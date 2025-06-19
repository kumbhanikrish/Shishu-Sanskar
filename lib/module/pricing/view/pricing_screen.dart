
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/module/pricing/model/pricing_model.dart';
import 'package:shishu_sanskar/module/pricing/view/widget/custom_pricing_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  List<PricingModel> pricingList = [];
  PricingModel? selectedPricingModel;

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
                                : ListView.separated(
                                  itemCount: pricingList.length,
                                  separatorBuilder: (_, __) => Gap(20),
                                  itemBuilder: (_, index) {
                                    PricingModel model = pricingList[index];
                                    return customPricingCard(
                                      image:
                                          model.title == 'Online'
                                              ? AppImage.online
                                              : AppImage.offline,
                                      name: model.title,
                                      price: '₹${model.price}',
                                      onTap: () {
                                        // selectedPricingModel = model;
                                        // openCheckout(model);
                                        Navigator.pushNamed(
                                          context,
                                          AppPage.payDetailScreen,

                                          arguments: {'pricingModel': model},
                                        );
                                      },
                                      backgroundColor:
                                          AppColor.themePrimaryColor,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: model.services.length,
                                        itemBuilder: (_, i) {
                                          return customDoneIconAndText(
                                            text: model.services[i],
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
