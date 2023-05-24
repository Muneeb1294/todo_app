import 'package:flutter/material.dart';
import 'package:note_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

import 'app_localization.dart';

class AppDecoration {
  InputDecoration fieldDecoration({
    Widget? preIcon,
    required String hintText,
    Widget? suffixIcon,
    double? radius,
    double? horizontalPadding,
    double? verticalPadding,
    double? iconMinWidth,
    Color? fillColor,
    FocusNode? focusNode,
  }) {
    return InputDecoration(
      prefixIconConstraints: BoxConstraints(
        minWidth: iconMinWidth ?? 42,
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 16, vertical: verticalPadding ?? 16),
      fillColor: fillColor ?? R.colors.fieldFill,
      hintText: LocalizationMap.getValue(hintText),
      prefixIcon: preIcon,
      suffixIcon: suffixIcon != null ? Container(child: suffixIcon) : null,
      hintStyle: R.textStyles.montserrat(
        color: R.colors.fieldHint,
        fontSize: 12.sp,
        fontWeight:
            focusNode?.hasFocus ?? false ? FontWeight.w500 : FontWeight.w300,
      ),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.fieldBorder),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.fieldBorder),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.fieldBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.themeColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      filled: true,
    );
  }

  BoxDecoration cardBoxDecoration({double? radius, bool? selectedCard}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 12),
      border: Border.all(
          color:
              selectedCard == true ? R.colors.colorTeal : R.colors.transparent,
          width: 1.5),
      color: R.colors.white,
      boxShadow: [
        BoxShadow(
          color: R.colors.black.withOpacity(0.16),
          offset: const Offset(10.0, 0),
          blurRadius: 35.0,
        ),
      ],
    );
  }
}
