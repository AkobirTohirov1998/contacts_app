import 'package:first_app/resources/colors.dart';
import 'package:flutter/material.dart';

TextStyle TS_LANG_TITLE([Color textColor = Colors.black87]) {
  return TextStyle(
    color: textColor,
    fontSize: 28.0,
    fontFamily: "Roboto",
  );
}

TextStyle TS_LANG([Color textColor = Colors.black87]) {
  return TextStyle(
    color: textColor,
    fontSize: 24.0,
    fontFamily: "Roboto",
  );
}

TextStyle TS_HeadLine6([Color textColor = Colors.black87]) {
  return TextStyle(
    color: textColor,
    fontSize: 20.0,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w500,
  );
}

TextStyle TS_HeadLine4({Color textColor = Colors.black87, double fontSize = 34.0}) {
  return TextStyle(
    color: textColor,
    fontSize: fontSize,
    fontFamily: "Roboto",
  );
}

TextStyle TS_Body_2([Color textColor = Colors.black87]) {
  return TextStyle(
      color: textColor,
      fontSize: 14.0,
      letterSpacing: 0.25,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400);
}

TextStyle TS_Body_1([Color textColor = Colors.black87, double fontSize = 16.0]) {
  return TextStyle(
    color: textColor,
    fontSize: fontSize,
    letterSpacing: 0.5,
    fontFamily: "Roboto",
  );
}

TextStyle TS_Overline([Color textColor = Colors.black87, double fontSize = 10.0]) {
  return TextStyle(
    color: textColor,
    fontSize: fontSize,
    letterSpacing: 1.5,
    fontFamily: "Roboto",
  );
}

TextStyle TS_Subtitle_1([Color textColor = Colors.black87]) {
  return TextStyle(
    color: textColor,
    fontSize: 16.0,
    letterSpacing: 0.15,
    fontFamily: "Roboto",
  );
}

TextStyle TS_Subtitle_2([Color textColor = Colors.black]) {
  return TextStyle(
      color: textColor,
      fontSize: 14.0,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontFamily: "Roboto");
}

TextStyle TS_ErrorText({Color textColor = Colors.redAccent, double fontSize = 12.0}) {
  return TextStyle(color: textColor, fontSize: fontSize, letterSpacing: 0.4);
}

TextStyle TS_Title2([Color textColor]) {
  return TextStyle(
      color: textColor ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: 26,
      fontWeight: FontWeight.w500,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}

TextStyle TS_Title3([Color textColor, double fontSize = 20]) {
  return TextStyle(
      color: textColor ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}

TextStyle TS_Title4([Color textColor, double fontSize = 16]) {
  return TextStyle(
      color: textColor ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}

TextStyle TS_Title5([Color textColor, double fontSize = 14.0]) {
  return TextStyle(
      color: textColor ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: "Rubik",
      letterSpacing: 0.01,
      fontStyle: FontStyle.normal);
}

TextStyle TS_Paragraph(
    [Color textColor, double fontSize = 14.0, FontWeight fontWeight = FontWeight.w400]) {
  return TextStyle(
      color: textColor ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}

TextStyle TS_Caption([Color color, bool underLine = false]) {
  return TextStyle(
      color: color ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: 12,
      letterSpacing: 0.02,
      fontWeight: FontWeight.w400,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}

TextStyle TS_BottomNavigationBar([Color color]) {
  return TextStyle(
      color: color ?? ExampleColor.getColor().text.medium_emphasis,
      fontStyle: FontStyle.normal,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Rubik',
      letterSpacing: 0.02);
}

TextStyle TS_Mono([Color color, bool underLine = false]) {
  return TextStyle(
      color: color ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: 12,
      fontWeight: FontWeight.w300,
      fontFamily: "IBM Plex Mono",
      fontStyle: FontStyle.normal);
}

TextStyle TS_Button([Color color, bool underLine = false]) {
  return TextStyle(
      color: color ?? ExampleColor.getColor().text.high_emphasis,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: "Rubik",
      fontStyle: FontStyle.normal);
}
