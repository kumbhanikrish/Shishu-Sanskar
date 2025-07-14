import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/module/pricing/model/pricing_model.dart';
import 'package:shishu_sanskar/module/pricing/view/widget/custom_pricing_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class PayDetailScreen extends StatefulWidget {
  final dynamic argument;
  const PayDetailScreen({super.key, this.argument});

  @override
  State<PayDetailScreen> createState() => _PayDetailScreenState();
}

class _PayDetailScreenState extends State<PayDetailScreen> {
  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    PricingCubit pricingCubit = BlocProvider.of<PricingCubit>(context);

    PricingModel pricingModel = widget.argument['pricingModel'];
    log("SUCCESS: ${response.paymentId}");

    Map<String, dynamic> params = {
      "razorpay_payment_id": response.paymentId,
      "razorpay_order_id": response.paymentId,
      "plan_id": pricingModel.id, // or selectedPricingModel!.planId
    };

    pricingCubit.payment(context, params: params);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log("ERROR: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("EXTERNAL WALLET: ${response.walletName}");
  }

  Future<void> openCheckout(PricingModel pricingModel) async {
    LoginModel loginModel = await localDataSaver.getLoginModel();

    var options = {
      'key': dotenv.env['RAZORPAY_key'],
      'amount': (double.parse(pricingModel.price) * 100).toInt(),
      'name': 'Shishu Sanskar',
      'description': pricingModel.title,
      'prefill': {
        'contact': loginModel.user.contactNumber,
        'email': loginModel.user.email,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay Error: $e');
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PricingModel pricingModel = widget.argument['pricingModel'];
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
                child: SingleChildScrollView(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    pricingModel.title == 'Online'
                                        ? AppImage.online
                                        : AppImage.offline,
                                  ),
                                  Gap(5),
                                  CustomText(
                                    text: pricingModel.title,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: CustomText(
                                  text:
                                      '₹${double.parse(pricingModel.price).toStringAsFixed(0)}',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40,
                                  textAlign: TextAlign.right,
                                ),
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
                          amount:
                              '₹${double.parse(pricingModel.price).toStringAsFixed(0)}',
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

                        // pricingTextWithAmount(
                        //   text: 'Discount',
                        //   amount: '-₹1,000',
                        //   color: AppColor.themeSecondaryColor,
                        // ),
                        // Gap(10),
                        // DottedLine(
                        //   direction: Axis.horizontal,
                        //   alignment: WrapAlignment.center,
                        //   lineLength: double.infinity,
                        //   lineThickness: 1.0,
                        //   dashLength: 4.0,
                        //   dashColor: AppColor.dottedColor,

                        //   dashRadius: 0.0,
                        //   dashGapLength: 4.0,
                        // ),
                        // Gap(10),

                        // pricingTextWithAmount(
                        //   text: 'Choose plan',
                        //   amount: '14,000',
                        // ),
                        Gap(5.h),
                        CustomButton(
                          text:
                              'Pay ₹${double.parse(pricingModel.price).toStringAsFixed(0)}',
                          onTap: () {
                            openCheckout(pricingModel);
                          },
                        ),

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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
