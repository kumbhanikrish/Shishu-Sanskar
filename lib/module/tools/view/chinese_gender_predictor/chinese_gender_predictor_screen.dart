import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/tools/cubit/chinese_gender_predictor/chinese_gender_predictor_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class ChineseGenderPredictorScreen extends StatefulWidget {
  const ChineseGenderPredictorScreen({super.key});

  @override
  State<ChineseGenderPredictorScreen> createState() =>
      _ChineseGenderPredictorScreenState();
}

class _ChineseGenderPredictorScreenState
    extends State<ChineseGenderPredictorScreen> {
  final TextEditingController yourDateOfConceptionController =
      TextEditingController();
  final TextEditingController yourDateOfBirthController =
      TextEditingController();

  String? resultShot;
  String? result;

  final int currentYear = DateTime.now().year;
  final int dobStartYear = DateTime.now().year - 60;
  final int dobEndYear = DateTime.now().year - 16;
  final int conceptionStartYear = 2024;
  final int conceptionEndYear = 2039;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DatePickerCubit>(context).init();
    BlocProvider.of<DatePicker2Cubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);
    ChineseGenderPredictorCubit chineseGenderPredictorCubit =
        BlocProvider.of<ChineseGenderPredictorCubit>(context);

    chineseGenderPredictorCubit.init();
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              CustomToolsTitleBg(
                screenName: 'Chinese Gender Predictor',
                subTitle: 'Chinese Gender Predictor Chart and Calendar',
              ),
              Gap(40),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      BlocBuilder<DatePicker2Cubit, DateTime?>(
                        builder: (context, dobSelectDate) {
                          final formatted =
                              dobSelectDate != null
                                  ? DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(dobSelectDate)
                                  : '';
                          yourDateOfBirthController.text = formatted;

                          return CustomTextField(
                            text: 'Your Date of Birth:',
                            hintText: 'dd/mm/yyyy',
                            controller: yourDateOfBirthController,
                            readOnly: true,
                            suffixImage: AppImage.datePick,
                            onTap: () {
                              customDatePicker(
                                context,
                                firstDate: DateTime(dobStartYear),
                                lastDate: DateTime(dobEndYear),
                                value: [dobSelectDate],
                                onValueChanged: (value) {
                                  BlocProvider.of<DatePicker2Cubit>(
                                    context,
                                  ).selectDate(context, value.first);
                                },
                              );
                            },
                          );
                        },
                      ),
                      Gap(20),
                      BlocBuilder<DatePickerCubit, DateTime?>(
                        builder: (context, docSelectDate) {
                          final formatted =
                              docSelectDate != null
                                  ? DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(docSelectDate)
                                  : '';
                          yourDateOfConceptionController.text = formatted;

                          return CustomTextField(
                            text: 'Your Date of Conception:',
                            hintText: 'dd/mm/yyyy',
                            controller: yourDateOfConceptionController,
                            readOnly: true,
                            suffixImage: AppImage.datePick,
                            onTap: () {
                              customDatePicker(
                                context,
                                firstDate: DateTime(conceptionStartYear),
                                lastDate: DateTime(conceptionEndYear),
                                value: [docSelectDate],
                                onValueChanged: (value) {
                                  datePickerCubit.selectDate(
                                    context,
                                    value.first,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      Gap(20),
                      CustomButton(
                        text: 'Predict Baby Gender',
                        onTap: () {
                          final dob = datePickerCubit.state;
                          final doc = datePickerCubit.state;
                          if (dob != null && doc != null) {
                            chineseGenderPredictorCubit.predictGender(dob, doc);
                          }
                        },
                      ),
                      Gap(20),
                      BlocBuilder<
                        ChineseGenderPredictorCubit,
                        ChineseGenderPredictorState
                      >(
                        builder: (context, state) {
                          if (state is ChineseGenderPredictorCalculatorState) {
                            if (state.resultShot == 'Boy') {
                              return _buildResultBox(
                                AppImage.boy,
                                state.result,
                                AppColor.boyBgColor,
                                AppColor.congratulationsBoyColor,
                              );
                            } else if (state.resultShot == 'Girl') {
                              return _buildResultBox(
                                AppImage.girl,
                                state.result,
                                AppColor.girlBgColor,
                                AppColor.congratulationsGirlColor,
                              );
                            } else {
                              return CustomText(
                                text: state.result,
                                fontSize: 14,
                              );
                            }
                          }
                          return SizedBox.shrink();
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

  Widget _buildResultBox(
    String asset,
    String text,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Image.asset(asset),
          Gap(10),
          CustomText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
