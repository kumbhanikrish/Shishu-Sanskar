
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/auth_category_model.dart';
import 'package:shishu_sanskar/module/auth/view/widget/custom_login_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SelectCategoriesScreen extends StatefulWidget {
  final void Function() onTap;
  final void Function() backOnTap;

  const SelectCategoriesScreen({
    super.key,
    required this.onTap,
    required this.backOnTap,
  });

  @override
  State<SelectCategoriesScreen> createState() => _SelectCategoriesScreenState();
}

class _SelectCategoriesScreenState extends State<SelectCategoriesScreen> {
  @override
  void initState() {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.authCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectDateValue = '';

    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );
    DatePickerCubit datePickerCubit = BlocProvider.of<DatePickerCubit>(context);

    List<AuthCategoryModel> authCategoryList = [];

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomText(
              text: 'Select categories',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            Gap(5),
            CustomText(
              text: 'choose category',
              fontSize: 12,
              color: AppColor.subTitleColor,
            ),
            Gap(3.6.h),

            BlocBuilder<CategoryRadioCubit, int>(
              builder: (context, selectedCategory) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthCategoryState) {
                          authCategoryList = state.authCategoryList;
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: authCategoryList.length,

                          itemBuilder: (context, index) {
                            AuthCategoryModel authCategoryModel =
                                authCategoryList[index];
                            return customGenderRadio(
                              fillImage:
                                  selectedCategory == authCategoryModel.id
                                      ? AppImage.fillCircle
                                      : AppImage.circle,
                              buttonImage:
                                  selectedCategory == authCategoryModel.id
                                      ? AppImage.colorCircle
                                      : AppImage.circle,
                              genderIcon: '',
                              title: authCategoryModel.name,
                              onTap: () {
                                datePickerCubit.init();
                                categoryRadioCubit.selectCategory(
                                  authCategoryModel.id,
                                );
                              },
                              child:
                                  (selectedCategory == 2 &&
                                              authCategoryModel.id == 2) ||
                                          (selectedCategory == 3 &&
                                              authCategoryModel.id == 3)
                                      ? BlocBuilder<DatePickerCubit, DateTime?>(
                                        builder: (context, selectDate) {
                                          String formattedDate = '';

                                          if (selectDate != null) {
                                            formattedDate = DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(selectDate);
                                          }
                                          if (selectDateValue !=
                                              formattedDate) {
                                            selectDateValue = formattedDate;
                                          }
                                          return CustomLmpCard(
                                            selectDate: selectDate,
                                            selectDateValue: selectDateValue,
                                          );
                                        },
                                      )
                                      : SizedBox(),
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
