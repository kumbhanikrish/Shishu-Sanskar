import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/languages_model.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/module/profile/cubit/profile_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  void initState() {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    authCubit.init();

    authCubit.languages(context);
    userData();

    super.initState();
  }

  userData() async {
    LanguagesRadioCubit languagesRadioCubit =
        BlocProvider.of<LanguagesRadioCubit>(context);
    LoginModel loginModel = await localDataSaver.getLoginModel();

    languagesRadioCubit.selectLanguages(loginModel.user.languageId);
  }

  @override
  Widget build(BuildContext context) {
    LanguagesRadioCubit languagesRadioCubit =
        BlocProvider.of<LanguagesRadioCubit>(context);
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    List<LanguagesModel> languagesList = [];
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: [
              customAppBar(
                title: 'languages',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              BlocBuilder<LanguagesRadioCubit, int>(
                builder: (context, selectedLanguages) {
                  return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is LanguagesState) {
                        languagesList = state.languagesList;
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: languagesList.length,

                            itemBuilder: (context, index) {
                              LanguagesModel languagesModel =
                                  languagesList[index];
                              return customGenderRadio(
                                trailing: true,
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
                                onTap: () async {
                                  await profileCubit.editUserLanguage(
                                    context,
                                    languageId: languagesModel.id,
                                  );
                                  languagesRadioCubit.selectLanguages(
                                    languagesModel.id,
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Gap(10);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
