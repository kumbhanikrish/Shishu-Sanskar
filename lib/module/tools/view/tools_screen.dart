import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/tools/view/widget/custom_tools_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10);
            },
            itemBuilder: (BuildContext context, int index) {
              return ToolsCardView(
                imagePath: AppImage.toolsImage,
                title: 'Ovulation Calculator',
                subtitle:
                    'A Pregnancy Due Date Calculator is a tool that helps expectant mothers estimate the date when their baby is likely to be born.',
                onTap: () {
                 
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
