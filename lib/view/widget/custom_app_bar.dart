import 'package:flutter/material.dart';
import 'package:only_noodle/constants/app_colors.dart';
import 'package:only_noodle/constants/app_images.dart';
import 'package:only_noodle/view/widget/my_text_widget.dart';
import 'package:get/get.dart';

AppBar simpleAppBar({
  bool haveLeading = true,
  String? title,
  Widget? leadingWidget,
  bool? centerTitle = false,
  List<Widget>? actions,
  Color? bgColor,
  Color? contentColor,
  VoidCallback? onLeadingTap,
}) {
  return AppBar(
    backgroundColor: bgColor ?? Colors.transparent,
    centerTitle: centerTitle,
    automaticallyImplyLeading: false,
    titleSpacing: haveLeading ? 0.0 : 20,
    leading: haveLeading
        ? leadingWidget ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: GestureDetector(
                      onTap: onLeadingTap ?? () => Get.back(),
                      child: Image.asset(
                        Assets.imagesArrowBackRounded,
                        height: 32,
                        color: contentColor ?? null,
                      ),
                    ),
                  ),
                ],
              )
        : null,
    title: MyText(
      text: title ?? '',
      size: 16,
      color: contentColor ?? kTertiaryColor,
      weight: FontWeight.w500,
    ),
    actions: actions,
    elevation: 0,
  );
}

// AppBar customAppBar({
//   bool haveLeading = true,
//   String? title,
//   Widget? leadingWidget,
//   bool? centerTitle = true,
//   List<Widget>? actions,
//   Color? bgColor,
//   VoidCallback? onLeadingTap,
// }) {
//   return AppBar(
//     backgroundColor: Colors.transparent,
//     centerTitle: centerTitle,
//     automaticallyImplyLeading: false,
//     titleSpacing: 16.0,
//     leading: haveLeading
//         ? leadingWidget ??
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: onLeadingTap ?? () => Get.back(),
//                     child: Image.asset(Assets.imagesClose, height: 24),
//                   ),
//                 ],
//               )
//         : null,
//     title: MyText(
//       text: title ?? '',
//       size: 14,
//       color: kTertiaryColor,
//       weight: FontWeight.w600,
//     ),
//     actions: actions,
//   );
// }
