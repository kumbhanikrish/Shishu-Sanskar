import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  final String email;
  CreateNewPasswordScreen({super.key, required this.email});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    PasswordVisibilityCubit passwordVisibilityCubit =
        BlocProvider.of<PasswordVisibilityCubit>(context);
    CPasswordVisibilityCubit cPasswordVisibilityCubit =
        BlocProvider.of<CPasswordVisibilityCubit>(context);
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    passwordVisibilityCubit.init();
    cPasswordVisibilityCubit.init();

    return Column(
      children: [
        CustomText(
          text: 'Create New Password',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Gap(3.6.h),

        BlocBuilder<PasswordVisibilityCubit, bool>(
          builder: (context, isHidden) {
            return CustomTextField(
              text: 'Create New Password',
              obscureText: isHidden,

              hintText: 'Create New Password',
              prefixImage: AppImage.lock,
              controller: newPasswordController,
              suffixIcon: customPrefixIcon(
                onTap: () {
                  passwordVisibilityCubit.toggleVisibility();
                },
                image: isHidden ? AppImage.eyeSlash : AppImage.eye,
              ),
            );
          },
        ),
        Gap(10),

        BlocBuilder<CPasswordVisibilityCubit, bool>(
          builder: (context, isHidden) {
            return CustomTextField(
              text: 'Confirm Password',
              obscureText: isHidden,

              hintText: 'Confirm Password',
              prefixImage: AppImage.lock,
              controller: cPasswordController,
              suffixIcon: customPrefixIcon(
                onTap: () {
                  cPasswordVisibilityCubit.toggleVisibility();
                },
                image: isHidden ? AppImage.eyeSlash : AppImage.eye,
              ),
            );
          },
        ),

        Gap(20),
        CustomButton(
          text: 'Done',
          onTap: () {
            authCubit.resetPassword(
              context,
              email: email,
              newPassword: newPasswordController.text.trim(),
              passwordConfirmation: cPasswordController.text.trim(),
              stepperCubit: stepperCubit,
            );
          },
        ),
        Gap(20),
        CustomTextButton(
          text: 'Cancel',
          onPressed: () {
            stepperCubit.previousStep(step: 1);
          },
        ),
      ],
    );
  }
}
