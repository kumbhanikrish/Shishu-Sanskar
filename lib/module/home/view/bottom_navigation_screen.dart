import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/auth/cubit/auth_cubit.dart';
import 'package:shishu_sanskar/module/auth/model/auth_category_model.dart';
import 'package:shishu_sanskar/module/auth/model/login_model.dart';
import 'package:shishu_sanskar/module/blog/cubit/blog_cubit.dart';
import 'package:shishu_sanskar/module/blog/view/blog_screen.dart';
import 'package:shishu_sanskar/module/graph/view/graph_Screen.dart';
import 'package:shishu_sanskar/module/home/cubit/event/event_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/home/cubit/task/task_cubit.dart';
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

callApi(context) async {
  EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
  AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
  TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
  await authCubit.authCategory(context);
  await eventCubit.getEvent(context);
  await taskCubit.getTask(context);
}

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  List<AuthCategoryModel> authCategoryList = [];
  String initialCategoryValue = '';
  final ValueNotifier<LoginModel?> loginModelNotifier = ValueNotifier(null);
  final bool _notificationsEnabled = false;
  Future<void> loadLoginData({int? categoryId}) async {
    LoginModel model = await localDataSaver.getLoginModel();

    loginModelNotifier.value = model;
  }

  @override
  void initState() {
    loadLoginData();
    super.initState();
  }

  Future<int> categoryId() async {
    int categoryId = await localDataSaver.getCategoryId();
    return categoryId;
  }

  callApi(context) async {
    EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
    await authCubit.authCategory(context);
    await eventCubit.getEvent(context);
    await taskCubit.getTask(context);
  }

  @override
  Widget build(BuildContext context) {
    callApi(context);

    EventCubit eventCubit = BlocProvider.of<EventCubit>(context);
    TaskCubit taskCubit = BlocProvider.of<TaskCubit>(context);
    BlogCubit blogCubit = BlocProvider.of<BlogCubit>(context);

    BottomBarCubit bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    PricingCubit pricingCubit = BlocProvider.of<PricingCubit>(context);

    CategoryRadioCubit categoryRadioCubit = BlocProvider.of<CategoryRadioCubit>(
      context,
    );
    log('bottomBarCubit.statebottomBarCubit.state ::${bottomBarCubit.state}');

    return Scaffold(
      body: FutureBuilder(
        future: planId(),
        builder: (context, planId) {
          return BlocBuilder<BottomBarCubit, int>(
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
                        // state == 2 || state == 3
                        // ?
                        FutureBuilder(
                          future: categoryName(),

                          builder: (context, categoryName) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                planId.data != 0
                                    ? Expanded(
                                      child: CustomText(
                                        text: categoryName.data ?? '',

                                        color: AppColor.themePrimaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                    : Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColor.dividerColor,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          BlocBuilder<CategoryRadioCubit, int>(
                                            builder: (context, selectCategory) {
                                              return FutureBuilder(
                                                future: categoryId(),
                                                builder: (context, snapshot) {
                                                  return SizedBox(
                                                    width: 190,
                                                    child: BlocBuilder<
                                                      AuthCubit,
                                                      AuthState
                                                    >(
                                                      builder: (
                                                        context,
                                                        state,
                                                      ) {
                                                        if (state
                                                            is AuthCategoryState) {
                                                          authCategoryList =
                                                              state
                                                                  .authCategoryList;
                                                        }
                                                        log(
                                                          'snapshot.data ::${snapshot.data}',
                                                        );
                                                        AuthCategoryModel?
                                                        initialItem;
                                                        if (authCategoryList
                                                            .isNotEmpty) {
                                                          initialItem = authCategoryList
                                                              .firstWhere(
                                                                (item) =>
                                                                    item.id ==
                                                                    snapshot
                                                                        .data,
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
                                                          initialItem:
                                                              initialItem,
                                                          selectColor:
                                                              AppColor
                                                                  .blackColor,
                                                          items:
                                                              authCategoryList,

                                                          onChanged: (
                                                            value,
                                                          ) async {
                                                            // callApi(context);

                                                            await localDataSaver
                                                                .setCategoryId(
                                                                  value?.id ??
                                                                      0,
                                                                );

                                                            categoryRadioCubit
                                                                .selectCategory(
                                                                  value?.id ??
                                                                      0,
                                                                );
                                                            eventCubit.init();
                                                            eventCubit.getEvent(
                                                              context,
                                                            );

                                                            taskCubit.init();
                                                            taskCubit.getTask(
                                                              context,
                                                            );

                                                            blogCubit.getBlogs(
                                                              context,
                                                              search: '',
                                                            );
                                                            if (bottomBarCubit
                                                                    .state ==
                                                                3) {
                                                              pricingCubit
                                                                  .init();

                                                              pricingCubit.getPlans(
                                                                context,
                                                                categoryId:
                                                                    (value?.id)
                                                                        .toString(),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          Icon(Icons.arrow_drop_down_rounded),
                                        ],
                                      ),
                                    ),

                                // if (state == 2) ...[
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

                                // InkWell(
                                //   onTap: () {},
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //       top: 8,
                                //       left: 8,
                                //       bottom: 8,
                                //     ),
                                //     child: SvgPicture.asset(AppImage.notification),
                                //   ),
                                // ),
                              ],
                              // ],
                            );
                          },
                        ),
                        // : state == 1
                        // ? CustomText(
                        //   text: 'Blog',
                        //   textAlign: TextAlign.center,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 22,
                        // )
                        // : state == 0
                        // ? CustomText(
                        //   text: 'Graph',
                        //   textAlign: TextAlign.center,

                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 22,
                        // )
                        // : CustomText(
                        //   text: 'Tools',
                        //   textAlign: TextAlign.center,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 22,
                        // ),
                      ),
                      _buildScreen(state),
                    ],
                  ),
                  if (planId.data == 0 && state == 0) ...[
                    Container(
                      height: 100.h,
                      width: 100.w,
                      color: AppColor.themePrimaryColor2.withOpacity(0.5),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // Optional for rounded corners
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Plan is not Active',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              Gap(8),
                              CustomText(
                                text: 'Please active any plan then use this',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.subTitleColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
