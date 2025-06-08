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

class DueDateScreen extends StatelessWidget {
  DueDateScreen({super.key});

  List<String> calculateBasedOnList = [
    'First day of my last period',
    'Conception Date',
  ];

  final TextEditingController basedOnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);
    datePickerCubit.init();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        CustomDropWonFiled<String>(
                          text: 'Calculate Based On',
                          items: calculateBasedOnList,
                          initialItem: calculateBasedOnList[0],
                          onChanged: (value) {},
                        ),
                        Gap(20),

                        BlocBuilder<DatePickerCubit, DateTime?>(
                          builder: (context, basedSelectDate) {
                            String formattedDate = '';

                            if (basedSelectDate != null) {
                              formattedDate = DateFormat(
                                'dd/MM/yyyy',
                              ).format(basedSelectDate);
                            }

                            if (basedOnController.text != formattedDate) {
                              basedOnController.text = formattedDate;
                            }
                            return CustomTextField(
                              text: 'Calculate Based On',
                              hintText: 'dd/mm/yyyy',
                              readOnly: true,
                              controller: basedOnController,
                              suffixImage: AppImage.datePick,
                              onTap: () {
                                customDatePicker(
                                  context,
                                  value: [basedSelectDate],
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
                        CustomButton(text: 'Calculate', onTap: () {}),

                        Gap(20),

                        Column(
                          children: [
                            Container(
                              width: 100.h,
                              decoration: BoxDecoration(
                                color: AppColor.dueDateBgColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 14,
                              ),
                              child: CustomText(
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
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 14,
                              ),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: "March 13th, 2026",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  Gap(5),
                                  CustomText(
                                    text:
                                        "Only 39 Weeks 6 Days left until your baby is born!",
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
