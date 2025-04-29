import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/home/view/home_screen.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_bg.dart';
import 'package:shishu_sanskar/utils/widgets/custom_list_tile.dart';
import 'package:shishu_sanskar/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBarCubit, int>(
        builder: (context, state) {
          return Stack(
            children: [
              customBg(),
              Column(
                children: <Widget>[
                  Gap(5.h),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 14,
                      right: 20,
                      left: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Wellness Seekers',
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                              Icon(Icons.arrow_drop_down_rounded),
                            ],
                          ),
                        ),
                        SvgPicture.asset(AppImage.notification),
                      ],
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                            index: 0,
                            currentIndex: state,
                            icon: AppImage.home,
                            label: "Home",
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
                            icon: AppImage.pricing,
                            label: "Pricing",
                          ),
                          bottomBarTab(
                            context,
                            currentIndex: state,
                            index: 3,
                            icon: AppImage.graph,
                            label: "Graph",
                          ),
                          bottomBarTab(
                            context,
                            currentIndex: state,
                            index: 4,
                            icon: AppImage.profile,
                            label: "My Profile",
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
      return HomeScreen();
    case 1:
      return Center(child: Text('🔍 Search Screen'));
    case 2:
      return Center(child: Text('👤 Profile Screen'));
    default:
      return Center(child: Text('❓ Unknown Screen'));
  }
}
