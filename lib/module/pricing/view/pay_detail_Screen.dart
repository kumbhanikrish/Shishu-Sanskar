import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/pricing/view/widget/custom_pricing_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class PayDetailScreen extends StatelessWidget {
  const PayDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customBg(),

          Column(
            children: [
              customAppBar(
                title: 'Pricing',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.themeSecondaryColor,
                          ),
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppImage.offline),
                                  CustomText(
                                    text: 'Offline',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            CustomText(
                              text: '₹15,000',
                              fontWeight: FontWeight.w600,
                              fontSize: 40,
                            ),
                          ],
                        ),
                      ),
                      Gap(30),
                      CustomTextField(
                        hintText: 'Enter Promo Code',
                        text: 'Apply Promo Code',
                        prefixImage: AppImage.promoCodeIcon,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: CustomText(
                            text: 'APPLY',
                            color: AppColor.themePrimaryColor,

                            fontSize: 14,
                          ),
                        ),
                      ),

                      Gap(40),

                      pricingTextWithAmount(
                        text: 'Choose plan',
                        amount: '₹15,000',
                      ),
                      Gap(10),
                      DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: AppColor.dottedColor,

                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                      ),
                      Gap(10),

                      pricingTextWithAmount(
                        text: 'Discount',
                        amount: '-₹1,000',
                        color: AppColor.themeSecondaryColor,
                      ),
                      Gap(10),
                      DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: AppColor.dottedColor,

                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                      ),
                      Gap(10),

                      pricingTextWithAmount(
                        text: 'Choose plan',
                        amount: '14,000',
                      ),
                      Gap(5.h),
                      CustomButton(text: 'Pay ₹14,000', onTap: () {}),

                      CustomTextButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
