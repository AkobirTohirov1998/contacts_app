import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

// ignore: must_be_immutable
class VButton extends VWidget {
  factory VButton.normal({
    String text,
    IconData icon,
    int iconSize,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    @required AppButtonStyle style,
    double width,
    double height,
    Color color,
    Color textColor,
    Color iconColor,
    IconData leftIcon,
    IconData rightIcon,
    Widget leftWidget,
    Widget rightWidget,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    int flex,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding,
  }) {
    final buttonBackground = color ?? style.background;
    final buttonTextColor = textColor ?? style.textColor;
    final buttonIconColor = iconColor ?? style.iconColor;

    Widget left = leftWidget;
    if (left == null && leftIcon != null) {
      left = Icon(leftIcon, size: 16, color: buttonIconColor);
    }
    Widget right = rightWidget;
    if (right == null && rightIcon != null) {
      right = Icon(rightIcon, size: 16, color: buttonIconColor);
    }
    return VButton(
      text: text ?? "No name",
      textColor: buttonTextColor,
      icon: icon,
      iconSize: iconSize,
      iconColor: buttonIconColor,
      child: child,
      iconPadding: iconPadding,
      textAlign: TextAlign.center,
      leftWidget: left,
      rightWidget: right,
      width: width,
      height: height,
      flex: flex,
      background: buttonBackground,
      padding: padding ?? EdgeInsets.fromLTRB(4, 6, 4, 6),
      margin: EdgeInsets.all(4),
      onTap: onTap,
      onTapDown: onTapDown,
      elevation: 5,
      elevationColor: buttonBackground.withAlpha((255 * 0.4).toInt()),
      borderRadius: borderRadius,
    );
  }

  factory VButton.outline({
    String text,
    IconData icon,
    int iconSize,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    @required AppButtonStyle style,
    double width,
    double height,
    Color color,
    Color textColor,
    Color iconColor,
    IconData leftIcon,
    IconData rightIcon,
    Widget leftWidget,
    Widget rightWidget,
    Color background,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    int flex,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding,
  }) {
    final buttonBackground = color ?? style.background;
    final buttonTextColor = textColor ?? style.textColor;
    final buttonIconColor = iconColor ?? style.iconColor;

    Widget left = leftWidget;
    if (left == null && leftIcon != null) {
      left = Icon(leftIcon, size: 16, color: buttonIconColor);
    }
    Widget right = rightWidget;
    if (right == null && rightIcon != null) {
      right = Icon(rightIcon, size: 16, color: buttonIconColor);
    }
    return VButton(
      text: text ?? "No name",
      textColor: buttonTextColor ?? buttonBackground,
      icon: icon,
      iconSize: iconSize,
      iconColor: buttonIconColor,
      child: child,
      iconPadding: iconPadding,
      textAlign: TextAlign.center,
      leftWidget: left,
      rightWidget: right,
      width: width,
      height: height,
      flex: flex,
      background: background ?? Colors.transparent,
      padding: padding ?? EdgeInsets.fromLTRB(4, 4, 4, 4),
      margin: EdgeInsets.all(4),
      onTap: onTap,
      onTapDown: onTapDown,
      borderColor: buttonBackground,
      borderRadius: borderRadius,
    );
  }

  VButton({
    String text,
    Color textColor,
    IconData icon,
    int iconSize,
    Color iconColor,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    TextAlign textAlign,
    TextStyle textStyle,
    Widget leftWidget,
    Widget rightWidget,
    //
    double width,
    double height,
    int flex,
    Color background,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    //
    BorderRadius borderRadius,
    Color borderColor,
    double elevation,
    Color elevationColor,
  }) : super(
          child: child ??
              Row(
                children: [
                  if (leftWidget != null)
                    Container(
                      width: 20,
                      height: 20,
                      child: Padding(
                        child: leftWidget,
                        padding: EdgeInsets.only(right: 2),
                      ),
                    ),

                  ///
                  if (icon == null)
                    MyText(
                      text,
                      style:
                          textStyle ?? ExampleTheme.getTheme().textStyle.button(color: textColor),
                      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                      textAlign: textAlign,
                    )
                  else
                    Padding(
                      padding: iconPadding ?? EdgeInsets.only(left: 3, right: 3),
                      child: MyIcon.icon(icon, size: iconSize ?? 20, color: iconColor),
                    ),

                  ///
                  if (rightWidget != null)
                    Container(
                      width: 20,
                      height: 20,
                      child: Padding(
                        child: rightWidget,
                        padding: EdgeInsets.only(left: 2),
                      ),
                    )
                ]..removeWhere((e) => e == null),
                mainAxisAlignment: MainAxisAlignment.center,
              ),
          width: width,
          height: height,
          flex: flex,
          background: background,
          borderRadius: borderRadius ?? ExampleTheme.getTheme().button_radius,
          padding: padding,
          margin: margin,
          onTap: onTap,
          onTapDown: onTapDown,
          borderColor: borderColor,
          elevation: elevation,
          elevationColor: elevationColor,
        );

  @override
  Widget build(BuildContext context) {
    Widget widget = this.child;

    widget = this.buildPadding(widget, padding);

    widget = this.buildRadius(widget, borderRadius);

    widget = this.buildOnTap(widget, onTap, onTapDown: onTapDown, borderRadius: borderRadius);

    widget = Container(
      child: widget,
      constraints: BoxConstraints(
        minWidth: this.width ?? 40,
        minHeight: this.height ?? 40,
      ),
    );

    widget = this.buildBox(
      widget,
      width,
      height,
      background,
      borderRadius,
      borderColor,
      elevation,
      elevationColor,
    );

    widget = this.buildPadding(widget, margin);

    widget = this.buildExpanded(widget, flex);

    return Container(child: widget);
  }
}

class GLButton extends VWidget {
  factory GLButton.regular({
    String text,
    IconData icon,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    @required AppButtonStyle style,
    TextStyle textStyle,
    double width,
    double height,
    double iconSize,
    Color color,
    Color textColor,
    bool upperCase,
    bool lowerCase,
    Color iconColor,
    IconData leftIcon,
    IconData rightIcon,
    Widget leftWidget,
    Widget rightWidget,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    int flex,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin = const EdgeInsets.all(4),
  }) {
    final buttonBackground = color ?? style.background;
    final buttonTextColor = textColor ?? style.textColor;
    final buttonIconColor = iconColor ?? style.iconColor;

    Widget left = leftWidget;
    if (left == null && leftIcon != null) {
      left = Container(
        child: Icon(leftIcon, size: 16, color: buttonIconColor),
        width: 20,
        height: 20,
      );
    }
    Widget right = rightWidget;
    if (right == null && rightIcon != null) {
      right = Container(
        child: Icon(rightIcon, size: 16, color: buttonIconColor),
        width: 20,
        height: 20,
      );
    }
    return GLButton(
      text: text,
      textColor: buttonTextColor,
      textStyle: textStyle ??
          ExampleTheme.getTheme()
              .textStyle
              .buttonRegular(color: buttonTextColor ?? buttonBackground),
      icon: icon,
      iconSize: iconSize ?? 20,
      iconColor: buttonIconColor,
      child: child,
      iconPadding: iconPadding,
      textAlign: TextAlign.center,
      upperCase: upperCase,
      lowerCase: lowerCase,
      leftWidget: left,
      rightWidget: right,
      width: width,
      height: height ?? 40,
      flex: flex,
      background: buttonBackground,
      padding: padding ?? EdgeInsets.fromLTRB(4, 6, 4, 6),
      margin: margin,
      onTap: onTap,
      onTapDown: onTapDown,
      borderRadius: borderRadius,
    );
  }

  factory GLButton.small({
    String text,
    IconData icon,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    @required AppButtonStyle style,
    double width,
    Color color,
    Color textColor,
    Color iconColor,
    IconData leftIcon,
    IconData rightIcon,
    Widget leftWidget,
    Widget rightWidget,
    Color background,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    int flex,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding,
  }) {
    final buttonBackground = color ?? style.background;
    final buttonTextColor = textColor ?? style.textColor;
    final buttonIconColor = iconColor ?? style.iconColor;

    Widget left = leftWidget;
    if (left == null && leftIcon != null) {
      left = Container(
        child: Icon(leftIcon, size: 12, color: buttonIconColor),
        width: 16,
        height: 16,
      );
    }
    Widget right = rightWidget;
    if (right == null && rightIcon != null) {
      right = Container(
        child: Icon(rightIcon, color: buttonIconColor),
        width: 16,
        height: 16,
      );
    }
    return GLButton(
      text: text,
      textStyle:
          ExampleTheme.getTheme().textStyle.buttonSmall(color: buttonTextColor ?? buttonBackground),
      icon: icon,
      iconSize: 16,
      iconColor: buttonIconColor,
      child: child,
      iconPadding: iconPadding,
      textAlign: TextAlign.center,
      leftWidget: left,
      rightWidget: right,
      width: width,
      height: 32,
      flex: flex,
      background: buttonBackground,
      padding: padding ?? EdgeInsets.fromLTRB(4, 4, 4, 4),
      margin: EdgeInsets.all(4),
      onTap: onTap,
      onTapDown: onTapDown,
      borderRadius: borderRadius,
    );
  }

  GLButton({
    String text,
    Color textColor,
    IconData icon,
    double iconSize,
    Color iconColor,
    EdgeInsetsGeometry iconPadding,
    Widget child,
    TextAlign textAlign,
    TextStyle textStyle,
    bool upperCase,
    bool lowerCase,
    Widget leftWidget,
    Widget rightWidget,
    //
    double width,
    double height,
    int flex,
    Color background,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    //
    BorderRadius borderRadius,
    Color borderColor,
    double elevation,
    Color elevationColor,
  }) : super(
          child: child ??
              Row(
                children: [
                  if (leftWidget != null)
                    Padding(
                      child: leftWidget,
                      padding: EdgeInsets.only(right: 2),
                    ),

                  ///
                  if (icon == null)
                    MyText(
                      text,
                      style: textStyle ??
                          ExampleTheme.getTheme().textStyle.buttonRegular(color: textColor),
                      padding: EdgeInsets.only(left: 4, right: 4),
                      upperCase: upperCase,
                      lowerCase: lowerCase,
                      textAlign: textAlign,
                    )
                  else
                    Padding(
                      padding: iconPadding ?? EdgeInsets.only(left: 3, right: 3),
                      child: MyIcon.icon(icon, size: iconSize ?? 20, color: iconColor),
                    ),

                  ///
                  if (rightWidget != null)
                    Padding(
                      child: rightWidget,
                      padding: EdgeInsets.only(left: 2),
                    ),
                ]..removeWhere((e) => e == null),
                mainAxisAlignment: MainAxisAlignment.center,
              ),
          width: width,
          height: height,
          flex: flex,
          background: background,
          borderRadius: borderRadius ?? ExampleTheme.getTheme().button_radius,
          padding: padding,
          margin: margin,
          onTap: onTap,
          onTapDown: onTapDown,
          borderColor: borderColor,
          elevation: elevation,
          elevationColor: elevationColor,
        );

  @override
  Widget build(BuildContext context) {
    Widget widget = this.child;

    widget = this.buildPadding(widget, padding);

    widget = this.buildRadius(widget, borderRadius);

    widget = this.buildOnTap(widget, onTap, onTapDown: onTapDown, borderRadius: borderRadius);

    widget = Container(
      child: widget,
      constraints: BoxConstraints(
        minWidth: this.width ?? 40,
        minHeight: this.height ?? 40,
      ),
    );

    widget = this.buildBox(
      widget,
      width,
      height,
      background,
      borderRadius,
      borderColor,
      elevation,
      elevationColor,
    );

    widget = this.buildPadding(widget, margin);

    widget = this.buildExpanded(widget, flex);

    return Container(child: widget);
  }
}
