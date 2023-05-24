import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {
  TextStyle poppins({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.headingColor,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0.48,
      height: height ?? 0,
    );
  }

  TextStyle montserrat({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize ?? 11.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0.48,
      height: height ?? 0,
    );
  }

  TextStyle glinde({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'Glinde',
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.textColor,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0.48,
      height: height ?? 0,
    );
  }
}
