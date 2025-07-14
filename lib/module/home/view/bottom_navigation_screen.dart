import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/auth_category_model.dart';
import 'package:shishu_sanskar/module/blog/view/blog_screen.dart';
import 'package:shishu_sanskar/module/graph/view/graph_Screen.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/home/view/home_screen.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/module/pricing/cubit/pricing_cubit.dart';
import 'package:shishu_sanskar/module/pricing/view/pricing_screen.dart';
import 'package:shishu_sanskar/module/tools/view/tools_screen.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:shishu_sanskar/utils/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<AuthCategoryModel> authCategoryList = [];
  String initialCategoryValue = '';

  @override
  Widget build(BuildContext context) {
    BottomBarCubit bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    PricingCubit pricingCubit = BlocProvider.of<PricingCubit>(context);

    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );
    log('bottomBarCubit.statebottomBarCubit.state ::${bottomBarCubit.state}');

    // bottomBarCubit.init();

    return Scaffold(
      body: BlocBuilder<BottomBarCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              customBg(),
              Column(
                children: <Widget>[
                  Gap(4.h),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 14,
                      right: 20,
                      left: 20,
                    ),
                    child:
                        state == 2 || state == 3
                            ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: BlocBuilder<
                                          AuthCubit,
                                          AuthState
                                        >(
                                          builder: (context, state) {
                                            if (state is AuthCategoryState) {
                                              authCategoryList =
                                                  state.authCategoryList;
                                            }
                                            AuthCategoryModel? initialItem;
                                            if (authCategoryList.isNotEmpty) {
                                              initialItem = authCategoryList
                                                  .firstWhere(
                                                    (item) => item.id == 1,
                                                    orElse:
                                                        () =>
                                                            authCategoryList
                                                                .first,
                                                  );
                                            }

                                            return CustomWithOutDecorationDropWonFiled<
                                              AuthCategoryModel
                                            >(
                                              text: '',
                                              initialItem: initialItem,
                                              selectColor: AppColor.blackColor,
                                              items: authCategoryList,

                                              onChanged: (value) {
                                                categoryRadioCubit
                                                    .selectCategory(
                                                      value?.id ?? 0,
                                                    );

                                                if (bottomBarCubit.state == 3) {
                                                  pricingCubit.init();

                                                  pricingCubit.getPlans(
                                                    context,
                                                    categoryId:
                                                        (value?.id).toString(),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down_rounded),
                                    ],
                                  ),
                                ),
                                if (state == 2) ...[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppPage.settingScreen,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(AppImage.setting),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                        bottom: 8,
                                      ),
                                      child: SvgPicture.asset(
                                        AppImage.notification,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            )
                            : state == 1
                            ? CustomText(
                              text: 'Blog',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            )
                            : state == 0
                            ? CustomText(
                              text: 'Graph',
                              textAlign: TextAlign.center,

                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            )
                            : CustomText(
                              text: 'Tools',
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                  ),
                  _buildScreen(state),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BlocBuilder<BottomBarCubit, int>(
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.lightThemePrimaryColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bottomBarTab(
                            context,
                            currentIndex: state,
                            index: 0,
                            icon: AppImage.graph,
                            label: "Graph",
                          ),
                          bottomBarTab(
                            context,
                            index: 1,
                            currentIndex: state,
                            icon: AppImage.blog,
                            label: "Blog",
                          ),
                          bottomBarTab(
                            context,
                            index: 2,
                            currentIndex: state,
                            icon: AppImage.home,
                            label: "Home",
                          ),

                          bottomBarTab(
                            context,
                            index: 3,
                            currentIndex: state,
                            icon: AppImage.pricing,
                            label: "Pricing",
                          ),

                          bottomBarTab(
                            context,
                            currentIndex: state,
                            index: 4,
                            icon: AppImage.tools,
                            label: "Tools",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildScreen(int index) {
  switch (index) {
    case 0:
      return GraphScreen();
    case 1:
      return BlogScreen();
    case 2:
      return HomeScreen();
    case 3:
      return PricingScreen();
    case 4:
      return ToolsScreen();

    default:
      return Container();
  }
}
