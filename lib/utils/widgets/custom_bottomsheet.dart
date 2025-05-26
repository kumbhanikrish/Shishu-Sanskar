import 'package:flutter/material.dart';

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
