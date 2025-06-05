import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_check_box.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class DeleteAccountScreen extends StatelessWidget {
  DeleteAccountScreen({super.key});

  final List<String> deleteType = [
    'No longer needed',
    'Moving to a different app or platform.',
    'Worried about account security.',
    "Facing problems with the app's functionality.",
  ];
  final TextEditingController feedBackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ReasonCubit reasonCubit = BlocProvider.of<ReasonCubit>(context);

    reasonCubit.clearSelection();
    return Scaffold(
      body: Stack(
        children: [
          customBg(),
          Column(
            children: <Widget>[
              customAppBar(
                title: 'Delete account',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BlocBuilder<ReasonCubit, List<String>>(
                          builder: (context, selectedReasons) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: deleteType.length,
                              itemBuilder: (context, index) {
                                final isSelected = selectedReasons.contains(
                                  deleteType[index],
                                );
                                return CustomCheckbox(
                                  title: deleteType[index],
                                  isSelected: isSelected,
                                  onTap: () {
                                    context.read<ReasonCubit>().toggleReason(
                                      deleteType[index],
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                        Gap(20),
                        CustomText(
                          text:
                              'Is there anything else you want to share with us?',
                          fontSize: 12,
                        ),
                        Gap(14),
                        CustomTextField(
                          hintText: 'Type your message....',
                          controller: feedBackController,
                          line: 3,
                        ),
                        Gap(10.h),
                        CustomButton(
                          text: 'Continue',
                          onTap: () {
                            if (reasonCubit.state.isEmpty) {
                              customErrorToast(
                                context,
                                text:
                                    'Please select at least one reason for account deletion.',
                              );
                              return;
                            }
                            if (feedBackController.text.isEmpty) {
                              customErrorToast(
                                context,
                                text:
                                    'Please provide feedback for account deletion.',
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              AppPage.deletePasswordScreen,
                              arguments: {
                                'feedback': feedBackController.text,
                                'reasons': reasonCubit.state,
                              },
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomTextButton(
                            text: 'Cancel',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
