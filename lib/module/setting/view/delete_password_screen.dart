import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_dialog.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class DeletePasswordScreen extends StatelessWidget {
  DeletePasswordScreen({super.key});
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CPasswordVisibilityCubit cPasswordVisibilityCubit =
        BlocProvider.of<CPasswordVisibilityCubit>(context);
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
                        customDialog(
                          context,
                          title: 'Account Deletion Policy',
                          subtitle:
                              "Return within 15 days to keep your account and data. Otherwise, it's gone forever.",
                          cancelText: 'Cancel',
                          submitText: 'Delete account',
                          submitOnTap: () {},
                        );
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
