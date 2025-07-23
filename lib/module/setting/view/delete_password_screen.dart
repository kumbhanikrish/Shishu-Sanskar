
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class DeletePasswordScreen extends StatelessWidget {
  final dynamic arguments;
  DeletePasswordScreen({super.key, required this.arguments});
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CPasswordVisibilityCubit cPasswordVisibilityCubit =
        BlocProvider.of<CPasswordVisibilityCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    Future<LoginModel> loginData() async {
      LoginModel loginModel = await localDataSaver.getLoginModel();
      return loginModel;
    }

    String feedback = arguments['feedback'];
    List<String> reasons = arguments['reasons'];
    return Scaffold(
      body: Stack(
        children: [
          customBg(),

          Column(
            children: <Widget>[
              customAppBar(
                title: 'Password',
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
                    BlocBuilder<CPasswordVisibilityCubit, bool>(
                      builder: (context, isHidden) {
                        return CustomTextField(
                          text: 'Email',
                          obscureText: isHidden,

                          hintText: 'Enter Password',
                          prefixImage: AppImage.lock,
                          controller: passwordController,
                          suffixIcon: customPrefixIcon(
                            onTap: () {
                              cPasswordVisibilityCubit.toggleVisibility();
                            },
                            image: isHidden ? AppImage.eyeSlash : AppImage.eye,
                          ),
                        );
                      },
                    ),
                    Gap(10.h),
                    CustomButton(
                      text: 'Confirm',
                      onTap: () {
                        if (passwordController.text.isEmpty) {
                          customErrorToast(
                            context,
                            text: 'Please enter your password.',
                          );
                          return;
                        }
                        customDialog(
                          context,
                          title: 'Account Deletion Policy',
                          subtitle:
                              "Return within 15 days to keep your account and data. Otherwise, it's gone forever.",
                          cancelText: 'Cancel',
                          submitText: 'Delete account',
                          submitOnTap: () {
                            authCubit.deleteAccount(
                              context,
                              password: passwordController.text,
                              feedback: feedback,
                              reasons: reasons,
                            );
                          },
                        );
                      },
                    ),
                    Gap(20),
                    FutureBuilder(
                      future: loginData(),
                      builder: (context, snapshot) {
                        return snapshot.data?.user.googleToken != '' &&
                                snapshot.data?.user.googleToken != null
                            ? CustomText(
                              text:
                                  'If you have no password then contact to Admin',
                              color: AppColor.themeSecondaryColor,
                              fontSize: 14,
                            )
                            : SizedBox();
                      },
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
