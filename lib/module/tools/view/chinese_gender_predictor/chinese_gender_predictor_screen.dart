import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class ChineseGenderPredictorScreen extends StatelessWidget {
  ChineseGenderPredictorScreen({super.key});

  final TextEditingController yourDateOfConceptionController =
      TextEditingController();
  final TextEditingController yourDatePfBirthController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);
    DatePicker2Cubit datePicker2Cubit = BlocProvider.of<DatePicker2Cubit>(
      context,
    );
    datePickerCubit.init();
    datePicker2Cubit.init();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        BlocBuilder<DatePicker2Cubit, DateTime?>(
                          builder: (context, dobSelectDate) {
                            String formattedDate = '';

                            if (dobSelectDate != null) {
                              formattedDate = DateFormat(
                                'dd/MM/yyyy',
                              ).format(dobSelectDate);
                            }

                            if (yourDatePfBirthController.text !=
                                formattedDate) {
                              yourDatePfBirthController.text = formattedDate;
                            }
                            return CustomTextField(
                              text: 'Your Date of Birth:',
                              hintText: 'dd/mm/yyyy',
                              readOnly: true,
                              controller: yourDatePfBirthController,
                              suffixImage: AppImage.datePick,
                              onTap: () {
                                customDatePicker(
                                  context,
                                  value: [dobSelectDate],
                                  onValueChanged: (value) {
                                    datePicker2Cubit.selectDate(
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
                        BlocBuilder<DatePickerCubit, DateTime?>(
                          builder: (context, docSelectedDate) {
                            String formattedDate = '';

                            if (docSelectedDate != null) {
                              formattedDate = DateFormat(
                                'dd/MM/yyyy',
                              ).format(docSelectedDate);
                            }

                            if (yourDateOfConceptionController.text !=
                                formattedDate) {
                              yourDateOfConceptionController.text =
                                  formattedDate;
                            }

                            return CustomTextField(
                              text: 'Your Date of Conception:',
                              hintText: 'dd/mm/yyyy',
                              readOnly: true,

                              onTap: () {
                                customDatePicker(
                                  context,
                                  value: [docSelectedDate],
                                  onValueChanged: (value) {
                                    datePickerCubit.selectDate(
                                      context,
                                      value.first,
                                    );
                                  },
                                );
                              },
                              suffixImage: AppImage.datePick,
                              controller: yourDateOfConceptionController,
                            );
                          },
                        ),
                        Gap(20),
                        CustomButton(text: 'Predict Baby Gender', onTap: () {}),

                        Gap(20),

                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.boyBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              Image.asset(AppImage.boy),
                              Gap(10),
                              CustomText(
                                text: "Congratulations!!! It's a Boy.",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.congratulationsBoyColor,
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor.girlBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          padding: EdgeInsets.symmetric(vertical: 20),

                          child: Column(
                            children: [
                              Image.asset(AppImage.girl),
                              Gap(10),
                              CustomText(
                                text: "Congratulations!!! It's a Girl.",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColor.congratulationsGirlColor,
                              ),
                            ],
                          ),
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
