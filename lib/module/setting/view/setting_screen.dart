import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
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
  bool _notificationsEnabled = false;
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
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppPage.bottomNavigationScreen,
                    (route) => false,
                  );
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
                                      AppPage.editProfileScreen,
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
                    Gap(15),

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _InfoTile(
                            icon: Icons.pregnant_woman,
                            iconColor: AppColor.themePrimaryColor,
                            title: 'Pregnancy Status',
                            value: 'Pregnant',
                          ),

                          SizedBox(
                            height: 50,
                            child: DottedLine(
                              direction: Axis.vertical,
                              alignment: WrapAlignment.center,
                              lineLength: double.infinity,
                              lineThickness: 1.0,
                              dashLength: 4.0,
                              dashColor: AppColor.dottedColor,

                              dashRadius: 0.0,
                              dashGapLength: 4.0,
                            ),
                          ),

                          _InfoTile(
                            icon: Icons.emoji_events,
                            iconColor: AppColor.amberColor,
                            title: 'Current Plan',
                            value: 'Platinum',
                          ),
                        ],
                      ),
                    ),
                    Gap(20),

                    CustomListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),

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
                      contentPadding: EdgeInsets.symmetric(vertical: 10),

                      text: 'Notification',
                      leadingImage: '',
                      fontSize: 14,

                      trailingColor: AppColor.blackColor,
                      trailing: Transform.scale(
                        scale:
                            0.8, // Adjust this value to change the size (e.g., 0.8 = 80%)
                        child: CupertinoSwitch(
                          value: _notificationsEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ),
                    ),

                    customDividerWithOutTopBottomSpace(
                      color: AppColor.themePrimaryColor2,
                    ),
                    CustomListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),

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
                      contentPadding: EdgeInsets.symmetric(vertical: 10),

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
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
