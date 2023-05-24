// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/constants.dart';
import '../constants/enums.dart';

class HiveDb {
  static final _hive = Hive.box("db");

  static Future<void> setLanguage(String languageCode) async {
    log("Selected Language  : $languageCode");
    Constants.language = languageCode;
    _hive.put(HiveKeys.language, languageCode);
  }

  static Future<String?> getLanguage() async {
    String? data = _hive.get(HiveKeys.language);
    log("this is user set language ${data.toString()}");
    return data;
  }

  static Future<void> setToken(String token) async {
    log("this is set token $token");
    _hive.put(HiveKeys.token, token);
  }

  static Future<String?> getToken() async {
    String? data = _hive.get(HiveKeys.token);
    log("this is get token $data");
    if (data != null) {
      return data;
    } else {
      return null;
    }
  }

  static deleteData() {
    _hive.delete(HiveKeysEnum.token.index);
  }

  static Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }

    return await Hive.openBox(boxName);
  }
}

class HiveKeys {
  static int language = HiveKeysEnum.language.index;
  static int token = HiveKeysEnum.token.index;
}
