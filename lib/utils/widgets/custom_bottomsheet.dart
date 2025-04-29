import 'package:flutter/material.dart';
import 'package:shishu_sanskar/utils/theme/colors.dart';
import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
import 'package:shishu_sanskar/utils/widgets/custom_button.dart';

customBottomSheet(BuildContext context, {required Widget child}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    useSafeArea: true,
    builder: (context) {
      return child;
    },
  );
}
