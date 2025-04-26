// import 'package:flutter/material.dart';
// import 'package:shishu_sanskar/utils/theme/colors.dart';
// import 'package:shishu_sanskar/utils/widgets/custom_app_bar.dart';
// import 'package:shishu_sanskar/utils/widgets/custom_button.dart';

// customBottomSheet(
//   BuildContext context, {
//   required String title,
//   required Widget child,
// }) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     useSafeArea: true,
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//               child: SizedBox(
//                 height: 60,
//                 child: CustomAppBar(
//                   title: title,
//                   bottom: PreferredSize(
//                     preferredSize: const Size.fromHeight(1),
//                     child: Container(
//                       color: AppColor.themePrimary2Color,
//                       height: 0.5,
//                       margin: const EdgeInsets.symmetric(horizontal: 24),
//                     ),
//                   ),
//                   leading: CustomIconButton(
//                     icon: Icons.close,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             child,
//           ],
//         ),
//       );
//     },
//   );
// }
