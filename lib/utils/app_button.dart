import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../resources/app_localization.dart';

class AppButton extends StatefulWidget {
  final String buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? textSize;
  final double? borderRadius;
  final double? borderWidth;
  final double? letterSpacing;
  final double? textPadding;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? buttonWidth;

  const AppButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.textPadding,
    this.elevation,
    this.shadowColor,
    this.buttonWidth,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth ?? Get.width,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          elevation: widget.elevation ?? 3,
          padding: EdgeInsets.zero,
          side: BorderSide(
              color: widget.borderColor ?? R.colors.transparent,
              width: widget.borderWidth ?? 0),
          backgroundColor: widget.color ?? R.colors.themeYellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 35),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.textPadding ?? 10.sp),
          child: Text(
            LocalizationMap.getValue(widget.buttonTitle),
            textAlign: TextAlign.center,
            style: R.textStyles.poppins(
                fontSize: widget.textSize ?? 14.sp,
                fontWeight: widget.fontWeight ?? FontWeight.w600,
                color: widget.textColor ?? R.colors.white,
                letterSpacing: widget.letterSpacing ?? 0.44),
          ),
        ),
      ),
    );
  }
}
