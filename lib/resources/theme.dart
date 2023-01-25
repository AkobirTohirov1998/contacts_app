import 'package:first_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class ExampleTheme {
  static ExampleAppTheme getTheme() {
    return MoldStyle.getTheme();
  }
}

class ExampleAppTheme extends MoldTheme {
  final AppTabController tabController = AppTabController();

  final AppButtonNormal button_normal = AppButtonNormal();
  final AppButtonOutline button_outline = AppButtonOutline();
  final BorderRadius button_radius = BorderRadius.circular(6);

  final AppCalendarDay calendar_day = AppCalendarDay();
  final BorderRadius calendar_day_elips = BorderRadius.circular(22);
  final BorderRadius calendar_day_radius = BorderRadius.circular(12);

  final AppEditText edittext = AppEditText();
  final BorderRadius edittext_radius = BorderRadius.circular(6);

  final AppCardBlock card_block = AppCardBlock();
  final BorderRadius card_radius = BorderRadius.circular(8);

  final AppBottomNavigation bottomNavigation = AppBottomNavigation();

  final AppHeaderTitle title = AppHeaderTitle();

  final AppItem item = AppItem();

  final AppTextStyle textStyle = new AppTextStyle();
}

///-------------------------------------------------------------------------------------------------
class AppTabControllerStyle {
  final Color tabColor = ExampleColor.getColor().background2;
  final Color selectedTabColor = ExampleColor.getColor().background1;
  final Color textColor = ExampleColor.getColor().text.regular_high;
  final Color selectedTextColor = ExampleColor.getColor().text.regular_high;
}

class AppTabControllerRegularStyle extends AppTabControllerStyle {
  final Color tabColor = ExampleColor.getColor().block.background_1;
  final Color selectedTabColor = ExampleColor.getColor().background1;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color selectedTextColor = ExampleColor.getColor().text.regular_high;
}

class AppTabControllerAccentStyle extends AppTabControllerStyle {
  final Color tabColor = ExampleColor.getColor().block.background_1;
  final Color selectedTabColor = ExampleColor.getColor().regular_on_accent;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color selectedTextColor = ExampleColor.getColor().text.regular_high;
}

class AppTabController {
  final AppTabControllerStyle regular = AppTabControllerRegularStyle();
  final AppTabControllerStyle accent = AppTabControllerAccentStyle();
}
//--------------------------------------------------------------------------------------------------

class AppButtonNormal {
  final AppButtonStyle regular = ButtonRegular();
  final AppButtonStyle regular2 = ButtonRegular2();
  final AppButtonStyle regular3 = ButtonRegular3();
  final AppButtonStyle accent = ButtonAccent();
  final AppButtonStyle accent_pressed = ButtonAccentPressed();
  final AppButtonStyle contrast = ButtonContrastButton();
  final AppButtonStyle section_button = ButtonNormalSectionButton();
  final AppButtonStyle on_accent = ButtonNormalOnAccent();

  final AppButtonStyle primary1 = ButtonPrimary1();
  final AppButtonStyle primary2 = ButtonPrimary2();
  final AppButtonStyle primary3 = ButtonPrimary3();
  final AppButtonStyle success = ButtonSuccess();
  final AppButtonStyle error = ButtonError();
  final AppButtonStyle warning = ButtonWarning();
  final AppButtonStyle disable = ButtonDisable();
}

class AppButtonOutline {
  final AppButtonStyle regular = ButtonOutlineRegular();
  final AppButtonStyle accent = ButtonOutlineAccent();
  final AppButtonStyle accent_pressed = ButtonAccentOutlinePressed();

  final AppButtonStyle defaults = ButtonOutlineDefault();
  final AppButtonStyle defaultLight = ButtonOutlineDefaultLight();
  final AppButtonStyle primary1 = ButtonOutlinePrimary1();
  final AppButtonStyle success = ButtonOutlineSuccess();
  final AppButtonStyle error = ButtonOutlineError();
  final AppButtonStyle warning = ButtonOutlineWarning();
  final AppButtonStyle disable = ButtonOutlineDisable();

  final AppButtonStyle on_accent = ButtonOnAccet();
}

///-------------------------------------------------------------------------------------------------
class AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

///-------------------------------------------------------------------------------------------------
class ButtonOutlineDefault extends AppButtonStyle {
  final Color background = ExampleColor.getColor().border.medium_emphasis;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
}

class ButtonNormalSectionButton extends AppButtonStyle {
  final Color background = ExampleColor.getColor().background2;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonContrastButton extends AppButtonStyle {
  final Color background = ExampleColor.getColor().contrast;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonOnAccet extends AppButtonStyle {
  final Color background = Colors.transparent;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonOutlineDefaultLight extends AppButtonStyle {
  final Color background = ExampleColor.getColor().border.on_primary_high_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class ButtonOutlinePrimary1 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().primary.primary_1;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
}

class ButtonOutlineRegular extends AppButtonStyle {
  final Color background = ExampleColor.getColor().regular;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonOutlineAccent extends AppButtonStyle {
  final Color background = ExampleColor.getColor().regular_on_accent;
  final Color textColor = ExampleColor.getColor().accent;
  final Color iconColor = ExampleColor.getColor().accent;
}

class ButtonAccentOutlinePressed extends AppButtonStyle {
  final Color background = ExampleColor.getColor().accent_pressed;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonOutlineOnAccent extends AppButtonStyle {
  final Color background = ExampleColor.getColor().regular_on_accent;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonOutlineSuccess extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.success;
  final Color textColor = ExampleColor.getColor().status.success;
  final Color iconColor = ExampleColor.getColor().status.success;
}

class ButtonOutlineError extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.error_regular;
  final Color textColor = ExampleColor.getColor().status.error_regular;
  final Color iconColor = ExampleColor.getColor().status.error;
}

class ButtonOutlineWarning extends AppButtonStyle {
  final Color background = Colors.transparent;
  final Color textColor = ExampleColor.getColor().status.warning_regular;
  final Color iconColor = ExampleColor.getColor().status.warning_regular;
}

class ButtonOutlineDisable extends AppButtonStyle {
  final Color background = Colors.transparent;
  final Color textColor = ExampleColor.getColor().status.new_disabled;
  final Color iconColor = ExampleColor.getColor().status.new_disabled;
}

class ButtonPrimary extends AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

///-------------------------------------------------------------------------------------------------
class ButtonRegular extends AppButtonStyle {
  final Color background = ExampleColor.getColor().button_regular;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonRegular2 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().background1;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonRegular3 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().background2;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonAccent extends AppButtonStyle {
  final Color background = ExampleColor.getColor().accent;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonAccentPressed extends AppButtonStyle {
  final Color background = ExampleColor.getColor().accent_pressed;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonNormalOnAccent extends AppButtonStyle {
  final Color background = ExampleColor.getColor().regular_on_accent;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

class ButtonRegularOnAccent extends AppButtonStyle {
  final Color background = ExampleColor.getColor().regular_on_accent;
  final Color textColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
}

///-------------------------------------------------------------------------------------------------
class ButtonPrimary1 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class ButtonPrimary2 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_2;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class ButtonPrimary3 extends AppButtonStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class ButtonSuccess extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.success_regular;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonSuccesPressed extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.success_pressed;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonError extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.error_regular;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonPressedError extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.error_pressed;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonWarning extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.warning_regular;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonWarningPressed extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.warning_pressed;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
}

class ButtonDisable extends AppButtonStyle {
  final Color background = ExampleColor.getColor().status.new_disabled;
  final Color textColor = ExampleColor.getColor().text.regular_low;
  final Color iconColor = ExampleColor.getColor().text.regular_low;
}

//--------------------------------------------------------------------------------------------------

class AppCalendarDay {
  final AppCalendarDayStyle primary1 = CalendarDayPrimary1();
  final AppCalendarDayStyle primary2 = CalendarDayPrimary2();
  final AppCalendarDayStyle primary3 = CalendarDayPrimary3();
  final AppCalendarDayStyle accent = CalendarDayAccent();

  final AppCalendarDayStyle success = CalendarDaySuccess();
  final AppCalendarDayStyle error = CalendarDayError();
  final AppCalendarDayStyle warning = CalendarDayWarning();
  final AppCalendarDayStyle disable = CalendarDayDisable();
  final AppCalendarDayStyle defaults = CalendarDayDefault();
  final AppCalendarDayStyle regular = CalendarDayRegular();
  final AppCalendarDayStyle contrast = CalendarDayContrast();
}

///-------------------------------------------------------------------------------------------------
///
class AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final double elevation = 5;
  final Color elevationColor = ExampleColor.getColor().primary.primary_1.withAlpha(930);
  final Offset elevationOffset = Offset(0, 3);
}

///-------------------------------------------------------------------------------------------------
class CalendarDayAccent extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().accent;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
  final Color elevationColor = ExampleColor.getColor().accent.withAlpha(930);
}

class CalendarDayPrimary1 extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().primary.primary_1.withAlpha(930);
}

class CalendarDayPrimary2 extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().primary.primary_2;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().primary.primary_2.withAlpha(930);
}

class CalendarDayPrimary3 extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().primary.primary_3.withAlpha(930);
}

class CalendarDaySuccess extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().status.success;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().status.success.withAlpha(930);
}

class CalendarDayError extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().status.error;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().status.error.withAlpha(930);
}

class CalendarDayWarning extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().status.warning;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color elevationColor = ExampleColor.getColor().status.warning.withAlpha(930);
}

class CalendarDayDisable extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color textColor = ExampleColor.getColor().text.low_emphasis;
  final Color iconColor = ExampleColor.getColor().text.low_emphasis;
  final double elevation = 1;
  final Color elevationColor = Colors.black26;
  final Offset elevationOffset = Offset(0, 0);
}

class CalendarDayDefault extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final double elevation = 1;
  final Color elevationColor = Colors.black26;
  final Offset elevationOffset = Offset(0, 0);
}

class CalendarDayRegular extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().button_regular;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final double elevation = 0;
  final Color elevationColor = Colors.transparent;
  final Offset elevationOffset = Offset(0, 0);
}

class CalendarDayContrast extends AppCalendarDayStyle {
  final Color background = ExampleColor.getColor().contrast;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
  final double elevation = 0;
  final Color elevationColor = Colors.transparent;
  final Offset elevationOffset = Offset(0, 0);
}

//--------------------------------------------------------------------------------------------------

class AppEditText {
  final AppEditTextStyle disabled = new AppEditTextDisabled();
  final AppEditTextStyle defaults = new AppEditTextDefault();
  final AppEditTextStyle regular = new AppEditTextRegular();
  final AppEditTextStyle regular2 = new AppEditTextRegular2();
  final AppEditTextStyle filled = new AppEditTextFilled();
  final AppEditTextStyle focus = new AppEditTextFocus();
  final AppEditTextStyle error = new AppEditTextError();
  final AppEditTextStyle success = new AppEditTextSuccess();
  final AppEditTextStyle dark = new AppEditTextDark();
  final AppEditTextStyle darkDisabled = new AppEditTextDarkDisabled();
}

///-------------------------------------------------------------------------------------------------
///
class AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().border.low_emphasis;
  final Color textColor = ExampleColor.getColor().text.high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final Color backgroundHover = ExampleColor.getColor().block.surface_2;
  final AppButtonStyle buttonStyle = ButtonPrimary3();
}

///-------------------------------------------------------------------------------------------------
///
class AppEditTextDisabled extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().border.low_emphasis;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.low_emphasis;
  final Color labelTextColor = ExampleColor.getColor().text.low_emphasis;
  final Color iconColor = ExampleColor.getColor().text.low_emphasis;
  final Color backgroundHover = ExampleColor.getColor().block.surface_2;
  final AppButtonStyle buttonStyle = ButtonDisable();
}

class AppEditTextDefault extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().field_background_deault;
  final Color borderColor = null;
  final Color textColor = ExampleColor.getColor().text.regular_high;
  final Color hintTextColor = ExampleColor.getColor().text.regular_medium;
  final Color labelTextColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final Color backgroundHover = ExampleColor.getColor().field_background_deault;
  final AppButtonStyle buttonStyle = ButtonPrimary3();
}

class AppEditTextRegular extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().background1;
  final Color borderColor = null;
  final Color textColor = ExampleColor.getColor().text.regular_high;
  final Color hintTextColor = ExampleColor.getColor().text.regular_medium;
  final Color labelTextColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
  final Color backgroundHover = ExampleColor.getColor().background1;
  final AppButtonStyle buttonStyle = ButtonRegular();
}

class AppEditTextRegular2 extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().background2;
  final Color borderColor = null;
  final Color textColor = ExampleColor.getColor().text.regular_high;
  final Color hintTextColor = ExampleColor.getColor().text.regular_medium;
  final Color labelTextColor = ExampleColor.getColor().text.regular_medium;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
  final Color backgroundHover = ExampleColor.getColor().background1;
  final AppButtonStyle buttonStyle = ButtonRegular();
}

class AppEditTextFilled extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().border.low_emphasis;
  final Color textColor = ExampleColor.getColor().text.high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.high_emphasis;
  final Color backgroundHover = ExampleColor.getColor().block.surface_2;
  final AppButtonStyle buttonStyle = ButtonPrimary3();
}

class AppEditTextFocus extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().primary.primary_1;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
  final Color backgroundHover = ExampleColor.getColor().block.surface_2;
  final AppButtonStyle buttonStyle = ButtonPrimary1();
}

class AppEditTextError extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().status.error;
  final Color textColor = ExampleColor.getColor().text.high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().status.error;
  final Color iconColor = ExampleColor.getColor().status.error;
  final Color backgroundHover = ExampleColor.getColor().status.error_hover;
  final AppButtonStyle buttonStyle = ButtonError();
}

class AppEditTextSuccess extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().block.surface_2;
  final Color borderColor = ExampleColor.getColor().status.success;
  final Color textColor = ExampleColor.getColor().text.high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().status.success;
  final Color iconColor = ExampleColor.getColor().status.success;
  final Color backgroundHover = ExampleColor.getColor().status.success_hover;
  final AppButtonStyle buttonStyle = ButtonSuccess();
}

class AppEditTextDark extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color borderColor = ExampleColor.getColor().text.on_primary_medium_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color labelTextColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final AppButtonStyle buttonStyle = ButtonDisable();
}

class AppEditTextDarkDisabled extends AppEditTextStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color borderColor = ExampleColor.getColor().text.on_primary_low_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_medium_emphasis;
  final Color hintTextColor = ExampleColor.getColor().text.on_primary_medium_emphasis;
  final Color labelTextColor = ExampleColor.getColor().text.on_primary_medium_emphasis;
  final Color iconColor = ExampleColor.getColor().text.on_primary_medium_emphasis;
  final AppButtonStyle buttonStyle = ButtonDisable();
}

//--------------------------------------------------------------------------------------------------

class AppCardBlock {
  final AppCardStyle light = new AppCardLight();
  final AppCardStyle dark = new AppCardDark();

  final AppCardStyle glLight = new AppGLCardLight();
  final AppCardStyle glLightWithShadow = new AppGLShadowedCardStyle();
}

///-------------------------------------------------------------------------------------------------
///
class AppCardStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final EdgeInsetsGeometry margin = EdgeInsets.all(4);
  final double elevation = 4.0;
  final Color elevationColor = Colors.black12;
}

///-------------------------------------------------------------------------------------------------
///
class AppCardLight extends AppCardStyle {
  final Color background = ExampleColor.getColor().block.surface;
}

class AppGLCardStyle extends AppCardStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final EdgeInsetsGeometry margin = EdgeInsets.zero;
  final double elevation = 0.0;
  final Color elevationColor = null;
}

class AppGLCardLight extends AppGLCardStyle {
  final Color background = ExampleColor.getColor().block.background_1;
}

class AppGLShadowedCardStyle extends AppGLCardStyle {
  final Color background = ExampleColor.getColor().block.background_1;
  final Color elevationColor = Color(0x26000000);
  final double elevation = 2.0;
}

class AppCardDark extends AppCardStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
}

//--------------------------------------------------------------------------------------------------

class AppBottomNavigation {
  final AppBottomNavigationStyle outline_accent = new AppBottomNavigationOutlineAccent();
  final AppBottomNavigationStyle accent = new AppBottomNaviagtionAccent();
  final AppBottomNavigationStyle regular = new AppBottomNavigationRegular();
  final AppBottomNavigationStyle defaults = new AppBottomNavigationDefault();
  final AppBottomNavigationStyle selected = new AppBottomNavigationSelected();
  final AppBottomNavigationStyle special = new AppBottomNavigationSpecial();
  final AppBottomNavigationStyle primary = new AppBottomNavigationPrimary();
  final AppBottomNavigationStyle apply = new AppBottomNavigationApply();
  final AppBottomNavigationStyle cancel = new AppBottomNavigationCancel();
  final AppBottomNavigationStyle disabled = new AppBottomNavigationDisabled();
}

///-------------------------------------------------------------------------------------------------
///
class AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

///-------------------------------------------------------------------------------------------------
///

class AppBottomNavigationDefault extends AppBottomNavigationStyle {
  final Color background = Colors.transparent;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
}

class AppBottomNavigationOutlineAccent extends AppBottomNavigationStyle {
  final Color background = Colors.transparent;
  final Color iconColor = ExampleColor.getColor().accent;
  final Color textColor = ExampleColor.getColor().accent;
}

class AppBottomNaviagtionAccent extends AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().accent;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
}

class AppBottomNavigationRegular extends AppBottomNavigationStyle {
  final Color background = Colors.transparent;
  final Color iconColor = ExampleColor.getColor().text.regular_high;
  final Color textColor = ExampleColor.getColor().text.regular_high;
}

class AppBottomNavigationSelected extends AppBottomNavigationStyle {
  final Color background = Colors.transparent;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().text.medium_emphasis;
}

class AppBottomNavigationSpecial extends AppBottomNavigationStyle {
  final Color background = Colors.transparent;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
  final Color textColor = ExampleColor.getColor().primary.primary_1;
}

class AppBottomNavigationPrimary extends AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().primary.primary_1;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class AppBottomNavigationApply extends AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().status.success;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class AppBottomNavigationCancel extends AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().status.error;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class AppBottomNavigationDisabled extends AppBottomNavigationStyle {
  final Color background = ExampleColor.getColor().status.disabled;
  final Color iconColor = ExampleColor.getColor().text.on_accent_high;
  final Color textColor = ExampleColor.getColor().text.on_accent_high;
}

//--------------------------------------------------------------------------------------------------

class AppHeaderTitle {
  final AppTitleStyle light = new AppTitleLight();
  final AppTitleStyle dark = new AppTitleDark();
}

///-------------------------------------------------------------------------------------------------
///
class AppTitleStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
  final Color titleColor = ExampleColor.getColor().text.high_emphasis;
  final Color subtitleColor = ExampleColor.getColor().text.high_emphasis;
  final AppButtonStyle buttonStyle = ButtonOutlineDefault();
}

///-------------------------------------------------------------------------------------------------
///
class _TitleLightButton extends ButtonOutlineDefault {
  final Color background = Colors.transparent;
  final Color textColor = ExampleColor.getColor().primary.primary_1;
}

class AppTitleLight extends AppTitleStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final Color iconColor = ExampleColor.getColor().primary.primary_1;
  final Color titleColor = ExampleColor.getColor().text.high_emphasis;
  final Color subtitleColor = ExampleColor.getColor().text.high_emphasis;
  final AppButtonStyle buttonStyle = _TitleLightButton();
}

class _TitleDarkButton extends ButtonOutlineDefault {
  final Color background = Colors.transparent;
  final Color textColor = ExampleColor.getColor().text.on_primary_high_emphasis;
}

class AppTitleDark extends AppTitleStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color titleColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color subtitleColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final AppButtonStyle buttonStyle = _TitleDarkButton();
}

//--------------------------------------------------------------------------------------------------

class AppItem {
  final AppItemStyle regular = new AppItemRegular();
  final AppItemStyle defaults = new AppItemDefault();
  final AppItemStyle dark = new AppItemDark();
}

///-------------------------------------------------------------------------------------------------
///
class AppItemStyle {
  final Color background = ExampleColor.getColor().block.surface;
  final Color iconColor = ExampleColor.getColor().text.medium_emphasis;
  final Color titleColor = ExampleColor.getColor().text.high_emphasis;
  final Color subtitleColor = ExampleColor.getColor().text.high_emphasis;
  final Color infoColor = ExampleColor.getColor().text.medium_emphasis;
  final AppButtonStyle buttonStyle = ButtonOutlineDefault();
}

///-------------------------------------------------------------------------------------------------
///
class AppItemDefault extends AppItemStyle {}

class AppItemRegular extends AppItemStyle {
  final Color background = ExampleColor.getColor().background1;
  final Color iconColor = ExampleColor.getColor().text.regular_medium;
  final Color titleColor = ExampleColor.getColor().text.regular_high;
  final Color subtitleColor = ExampleColor.getColor().text.regular_high;
  final Color infoColor = ExampleColor.getColor().text.regular_medium;
  final AppButtonStyle buttonStyle = ButtonOutlineDefault();
}

class AppItemDark extends AppItemStyle {
  final Color background = ExampleColor.getColor().primary.primary_3;
  final Color iconColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color titleColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final Color subtitleColor = ExampleColor.getColor().text.on_primary_high_emphasis;
  final AppButtonStyle buttonStyle = ButtonOutlineDefaultLight();
}

//--------------------------------------------------------------------------------------------------

class AppTextStyle {
  TextStyle title_2({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 26,
      height: 1.16,
      color: color);

  TextStyle title_3({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 20,
      height: 1.1,
      color: color);

  TextStyle title_4({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      height: 1.143,
      color: color);

  TextStyle title_5({Color color = Colors.black, double fontSize = 14.0}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      height: 1.333,
      color: color);

  TextStyle paragraph({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      height: 1.333,
      color: color);

  TextStyle paragraphBold({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: 14,
      height: 1.4,
      color: color);

  TextStyle caption({Color color = Colors.black, double fontSize = 12.0}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      height: 1.3,
      color: color);

  TextStyle captionBold({Color color = Colors.black, double fontSize = 12.0}) => TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      height: 1.3,
      color: color);

  TextStyle mono({Color color = Colors.black}) => TextStyle(
      fontFamily: 'IBMPlexMono',
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      fontSize: 14,
      height: 1.333,
      color: color);

  TextStyle button({Color color = Colors.black}) => TextStyle(
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      height: 1.0,
      color: color);

  TextStyle custom({Color color = Colors.black, double fontSize = 14.0}) => TextStyle(
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      height: 1.333,
      color: color);

  TextStyle buttonRegular({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.02,
      );

  TextStyle buttonSmall({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 12,
      );

  TextStyle body1({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 16,
        height: 1.0,
        letterSpacing: -0.02,
      );

  TextStyle body({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: color,
        height: 1.1429,
        letterSpacing: -0.015,
        fontSize: 14,
      );

  TextStyle bodyBold({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 14,
        height: 1.0,
        letterSpacing: -0.02,
      );

  TextStyle h6({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 14,
      );

  TextStyle h5({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 16,
        height: 1.25,
        letterSpacing: -0.02,
      );

  TextStyle h4({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 20,
        height: 1.2,
        letterSpacing: -0.025,
      );

  TextStyle h3({Color color = Colors.black}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 28,
        height: 1.15,
        letterSpacing: -0.03,
      );

  TextStyle h1({Color color}) => TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 36,
        letterSpacing: -0.02,
        height: 1.0,
      );

  TextStyle table({Color color}) => TextStyle(
        fontFamily: "Roboto Mono",
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 14,
        height: 1.14,
        letterSpacing: -0.015,
      );

  TextStyle tableBold({Color color}) => TextStyle(
        fontFamily: "Roboto Mono",
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: color,
        fontSize: 14,
        height: 1.14,
        letterSpacing: -0.015,
      );
}

//--------------------------------------------------------------------------------------------------
