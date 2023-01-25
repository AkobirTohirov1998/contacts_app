import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/gwslib.dart';

class AssertsImages {
  static final String splash_logo = "assets/libs/example/images/intro_logo.png";
  static final String intro_logo = "assets/libs/example/images/intro_logo.png";
  static final String finger_print = "assets/libs/accounts/images/finger_print.png";
  static final String default_profile_image =
      "assets/libs/accounts/images/default_profile_image.png";
  static final String avatar_male = "assets/libs/accounts/images/avatar_male.png";
  static final String avatar_female = "assets/libs/accounts/images/avatar_female.png";
}

class AssertsSvg {
  static final String drawer_menu = "assets/libs/accounts/svg/drawer_menu.svg";
  static final String edit_24 = "assets/libs/accounts/svg/edit_24.svg";
  static final String leading_back = "assets/libs/accounts/svg/leading_back.svg";

  static final String accountEmptyIcon = "assets/libs/accounts/svg/account_empty_icon.svg";
}

class AssertsColors {
  static final Map<String, String> _colors = {};

  ///getColor read color object  with colorKey from colors.json
  ///[name] color unique key in colors.json
  ///if [name] not fount throw Exception
  ///
  ///@return Color
  static Color getColor(String name) {
    return Util.fromHex(_colors[name]);
  }

  static void init() {
    final filePath = 'assets/colors.json';
    rootBundle.loadString(filePath).then((value) {
      AssertsColors._colors.clear();
      AssertsColors._colors.addAll((json.decode(value) as Map<String, dynamic>)
          .map((key, value) => MapEntry<String, String>(key, value.toString())));
    }).catchError((e, st) {
      Log.error(e, st);
      return "";
    });
  }

  static Color get app_color => getColor("app_color");

  static Color get toolbar_color => getColor("toolbar_color");

  static Color get toolbar_icon_color => getColor("toolbar_icon_color");

  static Color get background => getColor("background");

  static Color get green_light => getColor("green_light");

  static Color get status_success => AssertsColors.getColor("status_success");

  static Color get status_error => AssertsColors.getColor("status_error");

  static Color get status_attention => AssertsColors.getColor("status_attention");

  static Color get server_hint => getColor("server_hint");

  static Color get on_primary_high_emphasis => getColor("on_primary_high_emphasis");

  static Color get on_surface_medium_emphasis => getColor("on_surface_medium_emphasis");
}
