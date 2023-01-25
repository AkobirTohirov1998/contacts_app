import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/colors.dart' as acc_color;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkAccountAppColor extends ExampleAppColor {
  final Brightness brightness = Brightness.dark;
  final SystemUiOverlayStyle systemStyle = SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );
  final Color app_color = Color(0xFF1B82E3);
  final Color background = Color(0xFF000000);

  @override
  final BlockTheme block = DarkBlockTheme();
  final PrimaryTheme primary = DarkPrimaryTheme();
  final StatusTheme status = DarkStatusTheme();
  final acc_color.TextTheme text = DarkTextTheme();
  final BorderTheme border = DarkBorderTheme();
}

//--------------------------------------------------------------------------------------------------

class DarkBlockTheme extends BlockTheme {
  final Color surface = Color(0xFF101F29);
  final Color surface_2 = Color(0xFF142733);
  final Color background = Color(0xFF0C171F);
}

class DarkPrimaryTheme extends PrimaryTheme {
  final Color primary_1 = Color(0xFF1B82E3);
  final Color primary_2 = Color(0xFF32508A);
  final Color primary_3 = Color(0xFF0C2A3E);
}

class DarkStatusTheme extends StatusTheme {
  final Color success = Color(0xFF6E9530);
  final Color error = Color(0xFFB4495A);
  final Color warning = Color(0xFFD9AE42);
  final Color disabled = Color(0xFF363C40);
}

class DarkTextTheme extends acc_color.TextTheme {
  final Color high_emphasis = Color(0xE6B6CDE3);
  final Color medium_emphasis = Color(0x80B6CDE3);
  final Color low_emphasis = Color(0x61B6CDE3);

  final Color on_primary_high_emphasis = Color(0xE6B6CDE3);
  final Color on_primary_medium_emphasis = Color(0x80B6CDE3);
  final Color on_primary_low_emphasis = Color(0x61B6CDE3);
}

class DarkBorderTheme extends BorderTheme {
  final Color high_emphasis = Color(0xE6B6CDE3);
  final Color medium_emphasis = Color(0x80B6CDE3);
  final Color low_emphasis = Color(0x61B6CDE3);

  final Color on_primary_high_emphasis = Color(0xE6B6CDE3);
  final Color on_primary_medium_emphasis = Color(0x80B6CDE3);
  final Color on_primary_low_emphasis = Color(0x61B6CDE3);
}
