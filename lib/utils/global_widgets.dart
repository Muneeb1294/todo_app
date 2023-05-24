import 'package:flutter/material.dart';
import 'package:note_app/resources/app_localization.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';

class GlobalWidgets {
  static Widget fieldTitle(String localeTitle) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sp, bottom: 3.sp, left: 1.6.w),
      child: Text(
        LocalizationMap.getValue(localeTitle),
        style: R.textStyles.montserrat(
          fontSize: 12.sp,
          color: R.colors.headingColor,
          letterSpacing: 0.12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
