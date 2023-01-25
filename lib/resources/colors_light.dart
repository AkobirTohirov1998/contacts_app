import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/colors.dart' as acc_color;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightAccountAppColor extends ExampleAppColor {
  final Brightness brightness = Brightness.light;
  final SystemUiOverlayStyle systemStyle = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  final Color app_color = Color(0xFF1B82E3);
  final Color background = Color(0xFFE0E2E5);

  final Color regular = Color(0xFFD5D8DB);
  final Color regular_on_accent = Color(0xFFF2F5F6);
  final Color regular_pressed = Color(0xFFB5B8BA);

  final Color accent = Color(0xFF0178D4);
  final Color accent_pressed = Color(0xFF015BA1);

  final Color contrast = Color(0xFF16374D);
  final Color contrast_pressed = Color(0xFF07121A);

  final BlockTheme block = new LightBlockTheme();
  final PrimaryTheme primary = new LightPrimaryTheme();
  final StatusTheme status = new LightStatusTheme();
  final acc_color.TextTheme text = new LightTextTheme();
  final BorderTheme border = new LightBorderTheme();
}

//--------------------------------------------------------------------------------------------------

class LightBlockTheme extends BlockTheme {
  final Color surface = Color(0xFFFFFFFF);
  final Color surface_2 = Color(0xFFF5F6F7);
  final Color background = Color(0xFFE0E2E5);
}

class LightPrimaryTheme extends PrimaryTheme {
  final Color primary_1 = Color(0xFF1B82E3);
  final Color primary_2 = Color(0xFF32508A);
  final Color primary_3 = Color(0xFF0C2A3E);
}

class LightStatusTheme extends StatusTheme {
  final Color success = Color(0xFF82A846);
  final Color error = Color(0xFFCC5367);
  final Color warning = Color(0xFFD9AE42);
  final Color disabled = Color(0xFFC9CDD0);

  final Color new_disabled = Color(0xFFD5D8DB);

  final Color success_regular = Color(0xFF009131);
  final Color success_pressed = Color(0xFF007829);

  final warning_regular = Color(0xFFD98516);
  final warning_pressed = Color(0xFFBF7613);

  final error_regular = Color(0xFFD43315);
  final error_pressed = Color(0xFFBA2D13);
}

class LightTextTheme extends acc_color.TextTheme {
  final Color high_emphasis = Color(0xE50C2A3E);
  final Color medium_emphasis = Color(0x990C2A3E);
  final Color low_emphasis = Color(0x610C2A3E);

  final Color on_primary_high_emphasis = Color(0xDEFFFFFF);
  final Color on_primary_medium_emphasis = Color(0x99FFFFFF);
  final Color on_primary_low_emphasis = Color(0x61FFFFFF);

  final Color regular_high = Color(0xE60B293D);
  final Color regular_medium = Color(0xFF0B293D);
  final Color regular_low = Color(0x8A0B293D);

  final Color on_accent_high = Color(0xF2FFFFFF);
  final Color on_accent_low = Color(0x59FFFFFF);
}

class LightBorderTheme extends BorderTheme {
  final Color high_emphasis = Color(0x520C2A3E);
  final Color medium_emphasis = Color(0x3D0C2A3E);
  final Color low_emphasis = Color(0x290C2A3E);

  final Color on_primary_high_emphasis = Color(0x52FFFFFF);
  final Color on_primary_medium_emphasis = Color(0x3DFFFFFF);
  final Color on_primary_low_emphasis = Color(0x29FFFFFF);
}
