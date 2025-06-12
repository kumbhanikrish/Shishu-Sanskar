import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/country_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';

customCountryBottomSheet(BuildContext context, {required bool whatsapp}) {
  StoreNumberCubit storeNumberCubit = BlocProvider.of<StoreNumberCubit>(
    context,
  );
  StoreWpNumberCubit storeWpNumberCubit = BlocProvider.of<StoreWpNumberCubit>(
    context,
  );
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: AppColor.transparentColor,
    useSafeArea: true,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: countryList.length,

            itemBuilder: (BuildContext context, int index) {
              Map<String, String> countryData = countryList[index];

              return InkWell(
                onTap: () async {
                  if (whatsapp == false) {
                    storeNumberCubit.selectNumberCountry(
                      flag: countryData['flag'] ?? '',
                      code: countryData['dial_code'] ?? '',
                    );
                    Navigator.pop(context);
                  } else {
                    storeWpNumberCubit.selectWpNumberCountry(
                      flag: countryData['flag'] ?? '',
                      code: countryData['dial_code'] ?? '',
                    );
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: SizedBox(
                              height: 20,
                              width: 30,
                              child: SvgPicture.asset(
                                countryData['flag'] ?? '',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Gap(12),
                          CustomText(
                            text: countryData['name'] ?? '',
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ),

                    CustomText(
                      text: countryData['dial_code'] ?? '',
                      fontSize: 10,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Gap(12);
            },
          ),
        ),
      );
    },
  );
}

Widget buildOrDivider() {
  return Row(
    children: [
      Expanded(child: Divider(thickness: 1, color: AppColor.dividerColor)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomText(
          text: 'Or Sign Up With',
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(child: Divider(thickness: 1, color: AppColor.dividerColor)),
    ],
  );
}

customSocialMediaLogin({
  required void Function() googleOnTap,
  required void Function() appleOnTap,
}) {
  return Column(
    children: <Widget>[
      buildOrDivider(),
      Gap(20),

      Row(
        children: <Widget>[
          Expanded(
            child: CustomIconTextButton(
              text: 'Google',
              onTap: googleOnTap,
              image: AppImage.google,
            ),
          ),
          Gap(10),
          Expanded(
            child: CustomIconTextButton(
              text: 'Apple',
              onTap: appleOnTap,
              image: AppImage.apple,
            ),
          ),
        ],
      ),
    ],
  );
}

customGenderRadio({
  required String buttonImage,

  required String fillImage,
  required String genderIcon,
  required String title,
  required void Function() onTap,
  Widget? child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      border: Border.all(color: AppColor.themePrimaryColor2, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(buttonImage),

                    if (fillImage != '') ...[SvgPicture.asset(fillImage)],
                  ],
                ),
                if (genderIcon != '') ...[
                  Gap(13),
                  SvgPicture.asset(genderIcon),
                ],
                Gap(10),
                CustomText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            child ?? Container(),
          ],
        ),
      ),
    ),
  );
}

customNumberAndVerifiedText({
  required String text,
  required String verifiedText,
  void Function()? onTap,
  Color? color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Expanded(child: CustomText(text: text, fontSize: 12)),
      InkWell(
        onTap: onTap,
        child: CustomText(text: verifiedText, fontSize: 10, color: color),
      ),
    ],
  );
}

Widget buildStep(int index, int currentStep, int totalSteps) {
  final isActive = index == currentStep;
  final isCompleted = index < currentStep;

  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isCompleted || isActive
                  ? AppColor.themePrimaryColor
                  : AppColor.greyColor,
        ),
      ),

      if (index < 2)
        Container(
          width: 60,
          height: 1,
          color: isCompleted ? AppColor.themePrimaryColor : AppColor.greyColor,
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
    ],
  );
}

class CustomLmpCard extends StatelessWidget {
  final DateTime? selectDate;
  final String selectDateValue;
  const CustomLmpCard({
    super.key,
    required this.selectDate,
    required this.selectDateValue,
  });
  @override
  Widget build(BuildContext context) {
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(text: 'LMP', fontSize: 12),
                CustomText(
                  text: '(last menstrual period)',
                  fontSize: 10,
                  color: AppColor.subTitleColor,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.datePickerBk,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () async {
                customDatePicker(
                  context,
                  value: [selectDate],
                  onValueChanged: (value) {
                    datePickerCubit.selectDate(context, value.first);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    CustomText(
                      text:
                          selectDateValue == ''
                              ? 'dd/mm/yyyy'
                              : selectDateValue,
                      fontSize: 10,
                    ),
                    Gap(10),
                    SvgPicture.asset(AppImage.calendar),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
