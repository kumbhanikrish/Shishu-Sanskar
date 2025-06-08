import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shishu_sanskar/module/tools/model/tools_model.dart';
import 'package:shishu_sanskar/module/tools/view/widget/custom_tools_widget.dart';
import 'package:shishu_sanskar/utils/constant/app_image.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';

class ToolsScreen extends StatelessWidget {
  ToolsScreen({super.key});
  @override
  List<ToolsModel> toolsList = [
    ToolsModel(
      title: 'Ovulation Calculator',
      subtitle:
          'Ovulation is the process where a mature egg is released from the ovary into the fallopian tube.',
      image: AppImage.ovulationCalculator,
    ),
    ToolsModel(
      title: 'Due Date Calculator',
      subtitle:
          'A Pregnancy Due Date Calculator is a tool that helps expectant mothers estimate the date when their baby is likely to be born.',
      image: AppImage.dueDateCalculator,
    ),
    ToolsModel(
      title: 'Chinese Gender Predictor',
      subtitle:
          "A Chinese gender predictor chart guesses baby's sex by taking the mother's birth date and the estimated date of conception.",
      image: AppImage.chineseGenderPredictor,
    ),
    ToolsModel(
      title: 'Mood Tracker',
      subtitle:
          'focus on providing a supportive and informative experience, emphasizing the normalization of mood swings.',
      image: AppImage.dueDateCalculator,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: toolsList.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10);
            },
            itemBuilder: (BuildContext context, int index) {
              ToolsModel toolsModel = toolsList[index];
              return ToolsCardView(
                imagePath: toolsModel.image,
                title: toolsModel.title,
                subtitle: toolsModel.subtitle,
                onTap: () {
                  if (index == 0) {
                    Navigator.pushNamed(
                      context,
                      AppPage.ovulationCalculatorScreen,
                    );
                    return;
                  }

                  if (index == 1) {
                    Navigator.pushNamed(context, AppPage.dueDateScreen);
                    return;
                  }

                  if (index == 2) {
                    Navigator.pushNamed(
                      context,
                      AppPage.chineseGenderPredictorScreen,
                    );
                    return;
                  }

                  if (index == 3) {
                    return;
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
