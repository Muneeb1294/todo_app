// GENERAL APP BAR
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

AppBar appBar(
  String title, {
  void Function()? onPressed,
  bool isBackButton= false,
  double? elevation,
  IconData? icon,
  Color? color,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 50,
    elevation: elevation ?? 0,
    shadowColor: R.colors.shadow.withOpacity(.15),
    backgroundColor: R.colors.themeColor,
    centerTitle: true,
    leading: (isBackButton == false)
        ? null
        : IconButton(
            onPressed: onPressed ?? () => Get.back(),
            icon: Icon(
              icon ?? Icons.arrow_back_rounded,
              color: R.colors.white,
            ),
          ),
    title: Text(
      LocalizationMap.getValue(title),
      textAlign: TextAlign.center,
      style: R.textStyles.glinde(
        fontSize: 16.sp,
        color: R.colors.white,
        letterSpacing: 0.32,
        fontWeight: FontWeight.w600,
        height: 1.69,
      ),
    ),
  );
}
