import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_localization.dart';
import 'bot_toast/zbot_toast.dart';

class GlobalFunctions {

  static DateTime? currentBackPressTime;
  static Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    FocusScope.of(Get.context!).requestFocus(FocusNode());

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(
        message: LocalizationMap.getValue("press_again_to_exit"),
      );

      return Future.value(false);
    }
    return Future.value(true);
  }
}
