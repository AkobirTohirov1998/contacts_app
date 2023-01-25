import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:gwslib/preferences/pref.dart';

class SystemPref {
  static final int cThemeSystem = 0;
  static final int cThemeLight = 1;
  static final int cThemeDark = 2;

  static final String _MODULE = "account:system";

  //------------------------------------------------------------------------------------------------
  static final String _THEME = "theme";

  //------------------------------------------------------------------------------------------------

  static Future<int> getThemeType() {
    return Pref.load(_MODULE, _THEME).then((value) {
      if (Util.isEmpty(value)) {
        return cThemeSystem;
      } else {
        return int.parse(value);
      }
    });
  }

  static Future<void> setThemeType(int type) async {
    if (type == null || (type != cThemeLight && type != cThemeDark && type != cThemeSystem)) {
      throw Exception("type is null or unsupported Type:[$type]");
    }
    await Pref.save(_MODULE, _THEME, type.toString());
  }
}
