import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_list_tile.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);

  Future<void> loadLoginData() async {
    final model = await localDataSaver.getLoginModel();
    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    super.initState();
    loadLoginData();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Setting',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                child: Column(
                  children: <Widget>[
                    ValueListenableBuilder<LoginModel?>(
                      valueListenable: loginModelNotifier,
                      builder: (context, loginModelValue, _) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            border: Border.all(
                              color: AppColor.themePrimaryColor2,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 8.h,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColor.themePrimaryColor2,
                                      width: 2,
                                    ),
                                  ),

                                  child: ClipOval(
                                    child: CustomCachedImage(
                                      imageUrl:
                                          loginModelValue?.user.profileImage ??
                                          '',
                                    ),
                                  ),
                                ),
                                Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomText(
                                        text:
                                            '${loginModelValue?.user.firstName} ${loginModelValue?.user.middleName} ${loginModelValue?.user.lastName}',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Gap(5),
                                      CustomText(
                                        text: '${loginModelValue?.user.email}',
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppPage.profileScreen,
                                      arguments: {
                                        'loginModelValue': loginModelValue,
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.themePrimaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_sharp,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    CustomListTile(
                      text: 'Contact Us',
                      leadingImage: '',
                      fontSize: 14,
                      onTap: () {
                        Navigator.pushNamed(context, AppPage.contactUsScreen);
                      },
                      trailingColor: AppColor.blackColor,
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      text: 'Delete account',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppPage.deleteAccountScreen,
                        );
                      },
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppPage.privacyPolicyScreen,
                        );
                      },
                      text: 'Privacy Police',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
                    ),
                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      onTap: () {
                        customDialog(
                          context,
                          title: 'Log out?',
                          subtitle: "Are you sure you want to logout?",
                          cancelText: 'No',
                          submitText: 'Yes',
                          submitOnTap: () {
                            authCubit.logout(context);
                          },
                        );
                      },
                      text: 'Log out',
                      leadingImage: '',
                      fontSize: 14,
                      trailingColor: AppColor.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
