import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/view/number_screen.dart';
import 'package:shishu_sanskar/module/auth/view/sign_up_Screen.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_login_theme.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StepperCubit stepperCubit = BlocProvider.of<StepperCubit>(context);
    stepperCubit.init();
    return Scaffold(
      body: customLoginTheme(
        child: BlocBuilder<StepperCubit, int>(
          builder: (context, currentStep) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Gap(3.6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => buildStep(index, currentStep, 3),
                    ),
                  ),

                  Gap(3.6.h),

                  currentStep == 0
                      ? SignUpScreen(
                        fullNameController: fullNameController,
                        emailController: emailController,
                        cPasswordController: cPasswordController,
                        passwordController: passwordController,
                        onTap: () {
                          context.read<StepperCubit>().nextStep();
                        },
                      )
                      : currentStep == 1
                      ? NumberScreen()
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
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
