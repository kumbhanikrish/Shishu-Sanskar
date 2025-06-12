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

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PricingModel> pricingList = [];

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
                                  separatorBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    return Gap(20);
                                  },
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    PricingModel pricingModel =
                                        pricingList[index];
                                    return customPricingCard(
                                      image:
                                          pricingModel.title == 'Online'
                                              ? AppImage.online
                                              : AppImage.offline,
                                      name: pricingModel.title,
                                      price: '₹${pricingModel.price}',
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppPage.payDetailScreen,
                                        );
                                      },
                                      backgroundColor:
                                          AppColor.themePrimaryColor,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: pricingModel.services.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return customDoneIconAndText(
                                            text: pricingModel.services[index],
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
