import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/gwslib.dart';

class ExampleColor {
  static ExampleAppColor getColor() {
    return MoldStyle.getColor();
  }
}

class ExampleAppColor extends MoldColor {
  final Brightness brightness = Brightness.light;
  final SystemUiOverlayStyle systemStyle = SystemUiOverlayStyle.light;
  final Color app_color = Color(0xFF1B82E3);
  final Color background = Color(0xFFE0E2E5);

  final Color background1 = Color(0xFFFFFFFF);
  final Color background2 = Color(0xFFE6EAED);

  final Color field_background_deault = Color(0xFFE7EAEC);

  final Color regular = Color(0xFFD5D8DB);
  final Color button_regular = Color(0xFFD1DAE0);
  final Color regular_on_accent = Color(0xFFF2F5F6);
  final Color regular_pressed = Color(0xFFB5B8BA);

  final Color accent = Color(0xFF0178D4);
  final Color new_primary = Color(0xFF3B2AA3);
  final Color accent_pressed = Color(0xFF015BA1);

  final Color contrast = Color(0xFF16374D);
  final Color contrast_pressed = Color(0xFF07121A);

  final Color green = Color(0xFF009131);
  final Color green_hover = Color(0xFF009131).withOpacity(0.15);
  final Color on_accent_hight = Color(0xFFFFFFFF).withOpacity(0.62);

  final BlockTheme block = new BlockTheme();
  final PrimaryTheme primary = new PrimaryTheme();
  final StatusTheme status = new StatusTheme();
  final PriorityTheme priority = new PriorityTheme();
  final TextTheme text = new TextTheme();
  final BorderTheme border = new BorderTheme();
}

//--------------------------------------------------------------------------------------------------

class BlockTheme {
  final Color surface = Color(0xFFFFFFFF);
  final Color surface_2 = Color(0xFFF5F6F7);
  final Color background = Color(0xFFE0E2E5);

  final Color background_1 = Color(0xFFFFFFFF);
}

class PrimaryTheme {
  final Color primary_1 = Color(0xFF1B82E3);
  final Color primary_2 = Color(0xFF32508A);
  final Color primary_3 = Color(0xFF0C2A3E);
}

class StatusTheme {
  final Color success = Color(0xFF82A846);
  final Color error = Color(0xFFCC5367);
  final Color warning = Color(0xFFD9AE42);
  final Color disabled = Color(0xFFC9CDD0);
  final Color secondary = Color(0xFF055695);
  final Color info = Color(0xFF0178D4);
  final Color new_disabled = Color(0xFFD5D8DB);

  final Color success_regular = Color(0xFF009131);
  final Color success_pressed = Color(0xFF007829);
  final Color success_hover = Color(0xFFDAE5DE);

  final warning_regular = Color(0xFFD98516);
  final warning_pressed = Color(0xFFBF7613);
  final warning_hover = Color(0xFFF2EADF);

  final error_regular = Color(0xFFD43315);
  final error_pressed = Color(0xFFBA2D13);
  final error_hover = Color(0xFFEEE1DE);
}

class PriorityTheme{
  final Color priority_high_background = Color(0xD33C20).withOpacity(0.5);
  final Color priority_high_text_color = Color(0XD33C20);
}

class TextTheme {
  final Color high_emphasis = Color(0xE50C2A3E);
  final Color medium_emphasis = Color(0x990C2A3E);
  final Color low_emphasis = Color(0x610C2A3E);

  final Color on_primary_high_emphasis = Color(0xDEFFFFFF);
  final Color on_primary_medium_emphasis = Color(0x99FFFFFF);
  final Color on_primary_low_emphasis = Color(0x61FFFFFF);

  final Color regular_high = Color.fromRGBO(11, 41, 61, 0.9);
  final Color regular_medium = Color.fromRGBO(11, 41, 61, 0.6313725490196078);
  final Color regular_low = Color(0x330B293D);

  final Color on_accent_high = Color(0xFFFFFFFF).withOpacity(0.95);
  final Color on_accent_medium = Color(0xFFFFFFFF).withOpacity(0.62);
  final Color on_accent_low = Color(0xFFFFFFFF).withOpacity(0.35);
}

class BorderTheme {
  final Color high_emphasis = Color(0x520C2A3E);
  final Color medium_emphasis = Color(0x3D0C2A3E);
  final Color low_emphasis = Color(0x290C2A3E);

  final Color regular_low = Color(0x330B293D);
  final Color on_accent_hight_emphasis = Color(0x9EFFFFFF);
  final Color on_primary_high_emphasis = Color(0x52FFFFFF);
  final Color on_primary_medium_emphasis = Color(0x3DFFFFFF);
  final Color on_primary_low_emphasis = Color(0x29FFFFFF);
}
