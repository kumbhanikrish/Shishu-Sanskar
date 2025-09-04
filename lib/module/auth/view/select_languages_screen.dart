import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/languages_model.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SelectLanguagesScreen extends StatefulWidget {
  final void Function() onTap;
  final void Function() backOnTap;

  const SelectLanguagesScreen({
    super.key,
    required this.onTap,
    required this.backOnTap,
  });

  @override
  State<SelectLanguagesScreen> createState() => SelectLanguagesScreenState();
}

class SelectLanguagesScreenState extends State<SelectLanguagesScreen> {
  @override
  void initState() {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    LanguagesRadioCubit languagesRadioCubit =
        BlocProvider.of<LanguagesRadioCubit>(context);
    authCubit.init();

    languagesRadioCubit.init();
    authCubit.languages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguagesRadioCubit languagesRadioCubit =
        BlocProvider.of<LanguagesRadioCubit>(context);

    List<LanguagesModel> languagesList = [];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomText(
              text: 'Select Languages',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text: 'choose languages',
              fontSize: 12,
              color: AppColor.subTitleColor,
            ),
            Gap(3.6.h),

            BlocBuilder<LanguagesRadioCubit, int>(
              builder: (context, selectedLanguages) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is LanguagesState) {
                          languagesList = state.languagesList;

                          log('selectedLanguages ::$selectedLanguages');
                          if (selectedLanguages == -1 &&
                              languagesList.isNotEmpty) {
                            context.read<LanguagesRadioCubit>().selectLanguages(
                              languagesList.first.id,
                            );
                          }
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: languagesList.length,

                          itemBuilder: (context, index) {
                            LanguagesModel languagesModel =
                                languagesList[index];
                            return customGenderRadio(
                              fillImage:
                                  selectedLanguages == languagesModel.id
                                      ? AppImage.fillCircle
                                      : AppImage.circle,
                              buttonImage:
                                  selectedLanguages == languagesModel.id
                                      ? AppImage.colorCircle
                                      : AppImage.circle,
                              genderIcon: '',
                              title: languagesModel.name,
                              onTap: () {
                                languagesRadioCubit.selectLanguages(
                                  languagesModel.id,
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Gap(10);
                          },
                        );
                      },
                    ),
                    Gap(20),

                    CustomButton(text: 'Done', onTap: widget.onTap),

                    Align(
                      child: CustomTextButton(
                        text: 'Back',
                        onPressed: widget.backOnTap,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
