import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/enum/enums.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class NumberScreen extends StatelessWidget {
  NumberScreen({super.key});
  final TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RadioCubit radioCubit = BlocProvider.of<RadioCubit>(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
              text: 'Sign up',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text: 'Sign up to Create your account',
              fontSize: 12,
              color: AppColor.subTitleColor,
            ),
            Gap(3.6.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Gender',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                Gap(10),
                BlocBuilder<RadioCubit, UserType>(
                  builder: (context, selectedType) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          child: customGenderRadio(
                            fillImage:
                                selectedType == UserType.male
                                    ? AppImage.fillCircle
                                    : AppImage.circle,
                            buttonImage:
                                selectedType == UserType.male
                                    ? AppImage.colorCircle
                                    : AppImage.circle,
                            genderIcon: AppImage.male,
                            onTap: () {
                              radioCubit.selectUserType(UserType.male);
                            },
                            title: 'Male',
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: customGenderRadio(
                            fillImage:
                                selectedType == UserType.female
                                    ? AppImage.fillCircle
                                    : AppImage.circle,
                            buttonImage:
                                selectedType == UserType.female
                                    ? AppImage.colorCircle
                                    : AppImage.circle,
                            genderIcon: AppImage.female,
                            onTap: () {
                              radioCubit.selectUserType(UserType.female);
                            },
                            title: 'Male',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gap(10),
                CustomCountyTextfield(
                  controller: numberController,
                  onChanged: (value) {},
                  initialSelection: 'IN',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

customGenderRadio({
  required String buttonImage,

  required String fillImage,
  required String genderIcon,
  required String title,
  required void Function() onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.themePrimaryColor2, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(buttonImage),

                if (fillImage != '') ...[SvgPicture.asset(fillImage)],
              ],
            ),
            Gap(13),
            SvgPicture.asset(genderIcon),
            Gap(10),
            CustomText(text: title, fontSize: 12, fontWeight: FontWeight.w400),
          ],
        ),
      ),
    ),
  );
}
