import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/home/cubit/home_cubit.dart';
import 'package:shishu_sanskar/module/home/view/home_screen.dart';
import 'package:shishu_sanskar/module/home/view/widget/custom_home_widget.dart';
import 'package:shishu_sanskar/module/pricing/view/pricing_screen.dart';
import 'package:shishu_sanskar/module/profile/view/profile_screen.dart';
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
                    child:
                        state == 0 || state == 2
                            ? Row(
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
                                if (state == 0) ...[
                                  SvgPicture.asset(AppImage.notification),
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
                            : state == 3
                            ? CustomText(
                              text: 'Graph',
                              textAlign: TextAlign.center,

                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            )
                            : CustomText(
                              text: 'My Profile',
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
      return Center(child: Text('Blog Screen'));
    case 2:
      return PricingScreen();
    case 3:
      return Center(child: Text('Graph Screen'));
    case 4:
      return ProfileScreen();

    default:
      return Container();
  }
}
