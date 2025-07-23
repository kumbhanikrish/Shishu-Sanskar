import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/tools/cubit/due_date_calculator/due_date_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class DueDateScreen extends StatelessWidget {
  const DueDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final datePickerCubit = BlocProvider.of<DatePickerCubit>(context);
    final dueDateCubit = BlocProvider.of<DueDateCubit>(context);
    datePickerCubit.init();
    dueDateCubit.init();

    final basedOnController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              CustomToolsTitleBg(
                screenName: 'Due Date Calculator',
                subTitle: "Know the Date Of Your Baby's Arrival",
              ),
              Gap(40),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FutureBuilder(
                    future: lmpDate(),
                    builder: (context, snapshot) {
                      // DateFormat(
                      //   'dd/MM/yyyy',
                      // ).format(DateTime.parse(snapshot.data?.user.lmp ?? ''));
                      return BlocBuilder<DueDateCubit, DueDateState>(
                        builder: (context, state) {
                          if (state is! DueDateCalculatorState) {
                            return const SizedBox(); // or loading widget
                          }
                          log('snapshot.data?.user.lmp :${snapshot.data}');
                          final formattedDate =
                              state.selectedDate != null
                                  ? DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(state.selectedDate!)
                                  : snapshot.data == '' || snapshot.data == null
                                  ? ''
                                  : DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(DateTime.parse(snapshot.data ?? ''));

                          basedOnController.text = formattedDate;

                          return Column(
                            children: [
                              CustomDropWonFiled<String>(
                                text: 'Calculate Based On',
                                items: [
                                  'First day of my last period',
                                  'Conception Date',
                                ],
                                initialItem: state.selectedMethod,
                                onChanged:
                                    (value) =>
                                        dueDateCubit.changeMethod(value!),
                              ),
                              Gap(20),
                              CustomTextField(
                                text: 'Calculate Based On',
                                hintText: 'dd/mm/yyyy',
                                readOnly: true,
                                controller: basedOnController,
                                suffixImage: AppImage.datePick,
                                onTap: () {
                                  customDatePicker(
                                    context,
                                    value: [state.selectedDate],
                                    onValueChanged: (value) {
                                      dueDateCubit.selectDate(
                                        value.first ?? DateTime.now(),
                                      );
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),

                              Gap(20),
                              CustomButton(
                                text: 'Calculate',
                                onTap: () {
                                  if (state.selectedDate != null) {
                                    dueDateCubit.calculateDueDate();
                                  }
                                },
                              ),
                              Gap(20),
                              if (state.dueDate != null)
                                Column(
                                  children: [
                                    Container(
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.dueDateBgColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 14,
                                      ),
                                      child: const CustomText(
                                        text:
                                            "Congratulations! Your Baby's estimated due date is on or around",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 100.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.themePrimaryColor2,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 14,
                                      ),
                                      child: Column(
                                        children: [
                                          CustomText(
                                            text: DateFormat(
                                              "MMMM d, y",
                                            ).format(state.dueDate!),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                          Gap(5),
                                          CustomText(
                                            text: state.remainingText,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      );
                    },
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
