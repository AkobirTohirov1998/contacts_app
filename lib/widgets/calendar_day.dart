import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class VCalendarDay extends VWidget {
  final DateTime dateTime;
  final bool enableDots;
  final AppCalendarDayStyle style;
  final BorderRadius superellipseRadius;

  VCalendarDay({
    this.dateTime,
    @required this.style,
    this.enableDots = false,
    double width,
    double height,
    Color background,
    BorderRadius superellipseRadius,
    EdgeInsetsGeometry margin,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    //
    BorderRadius borderRadius,
    Color borderColor,
    double elevation,
    Color elevationColor,
  })  : this.superellipseRadius = superellipseRadius ?? ExampleTheme.getTheme().calendar_day_elips,
        super(
          child: Container(),
          width: width ?? 51.71,
          height: height ?? 38,
          background: background ?? style.background,
          borderRadius: BorderRadius.circular(10) ??
              borderRadius ??
              ExampleTheme.getTheme().calendar_day_radius,
          margin: margin ?? EdgeInsets.all(4),
          onTap: onTap,
          onTapDown: onTapDown,
          borderColor: borderColor,
          elevation: elevation ?? style.elevation,
          elevationColor: elevationColor ?? style.elevationColor,
        );

  @override
  Widget build(BuildContext context) {
    Widget widget = Padding(
      padding: EdgeInsets.all(2),
      child: Row(
        children: [
          this.buildText(),
          this.buildDot(),
        ]..removeWhere((e) => e == null),
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );

    widget = this.buildPadding(widget, padding);

    widget = this.buildOnTap(widget, onTap);

    if (this.superellipseRadius != null) {
      widget = Material(
        color: background,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        // shape: SuperellipseShape(borderRadius: this.superellipseRadius),
        child: Container(
          width: width,
          height: height,
          child: widget,
        ), // Container
      );
    }

    widget = this.buildBox(
      widget,
      width,
      height,
      Colors.transparent,
      this.borderRadius,
      borderColor,
      elevation,
      elevationColor,
      style.elevationOffset,
    );

    widget = this.buildPadding(widget, margin);

    return Container(child: widget);
  }

  Widget buildText() {
    final dateTime = this.dateTime ?? DateTime.now();
    final format = DateFormat("dd#EEE", AppLang.instance.getLangCode());
    final dayFormat = DateUtil.format(dateTime, format);
    final dayInfo = dayFormat.split("#");
    final day = dayInfo[0].trim();
    final weekName = dayInfo[1].trim().toLowerCase();

    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: Column(
        children: [
          MyText(
            day,
            style: ExampleTheme.getTheme().textStyle.bodyBold(color: style.textColor),
          ),
          MyText(
            weekName,
            style: ExampleTheme.getTheme().textStyle.caption(color: style.textColor, fontSize: 10),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget buildDot() {
    if (!enableDots) {
      return Expanded(child: Container());
    }
    return Expanded(
      child: Align(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: ClipRRect(
            child: Container(
              width: 4,
              height: 4,
              color: style.textColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        alignment: Alignment.bottomRight,
      ),
    );
  }
}

class GLCalendarDay extends VWidget {
  final DateTime dateTime;
  final bool enableDots;
  final AppCalendarDayStyle style;
  final BorderRadius superellipseRadius;
  final int badgeCount;

  GLCalendarDay({
    this.dateTime,
    @required this.style,
    this.enableDots = false,
    this.badgeCount,
    double width,
    double height,
    Color background,
    BorderRadius superellipseRadius,
    EdgeInsetsGeometry margin,
    GestureTapCallback onTap,
    GestureTapDownCallback onTapDown,
    //
    BorderRadius borderRadius,
    Color borderColor,
    double elevation,
    Color elevationColor,
  })  : this.superellipseRadius = superellipseRadius ?? ExampleTheme.getTheme().calendar_day_elips,
        super(
          child: Container(),
          width: width ?? 48,
          height: height ?? 48,
          background: background ?? style.background,
          borderRadius: borderRadius ?? ExampleTheme.getTheme().calendar_day_radius,
          margin: margin ?? EdgeInsets.all(4),
          onTap: onTap,
          onTapDown: onTapDown,
          borderColor: borderColor,
          elevation: elevation ?? style.elevation,
          elevationColor: elevationColor ?? style.elevationColor,
        );

  @override
  Widget build(BuildContext context) {
    Widget widget = Padding(
      padding: EdgeInsets.all(2),
      child: Row(
        children: [
          this.buildText(),
          this.buildDot(),
        ]..removeWhere((e) => e == null),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );

    widget = this.buildPadding(widget, padding);

    widget = this.buildOnTap(widget, onTap);

    if (this.superellipseRadius != null) {
      widget = Material(
        color: background,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        // shape: SuperellipseShape(borderRadius: this.superellipseRadius),
        child: Container(
          width: width,
          height: height,
          child: widget,
        ), // Container
      );
    }

    widget = this.buildBox(
      widget,
      width,
      height,
      Colors.transparent,
      this.borderRadius,
      borderColor,
      elevation,
      elevationColor,
      style.elevationOffset,
    );

    widget = this.buildPadding(widget, margin);

    if (badgeCount != null && badgeCount > 0) {
      Widget budgeWidget = buildRadius(
          Container(
            child: MyText(
              badgeCount > 99 ? "99+" : badgeCount.toString(),
              style: ExampleTheme.getTheme()
                  .textStyle
                  .captionBold(color: ExampleColor.getColor().regular_on_accent, fontSize: 11),
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.topLeft,
            color: ExampleColor.getColor().status.error,
            width: 22,
            height: 22,
          ),
          BorderRadius.circular(11));

      widget = Stack(
        children: [widget, budgeWidget],
        alignment: Alignment.topRight,
      );
    }

    return Container(child: widget);
  }

  Widget buildText() {
    final dateTime = this.dateTime ?? DateTime.now();
    final format = DateFormat("dd#EEE", AppLang.instance.getLangCode());
    final dayFormat = DateUtil.format(dateTime, format);
    final dayInfo = dayFormat.split("#");
    final day = dayInfo[0].trim();
    final weekName = dayInfo[1].trim().toLowerCase();

    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: Column(
        children: [
          MyText(
            day,
            style: ExampleTheme.getTheme().textStyle.bodyBold(color: style.textColor),
          ),
          MyText(
            weekName,
            style: ExampleTheme.getTheme().textStyle.caption(color: style.textColor, fontSize: 10),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget buildDot() {
    if (!enableDots) {
      return Expanded(child: Container());
    }
    return Expanded(
      child: Align(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: ClipRRect(
            child: Container(
              width: 4,
              height: 4,
              color: style.textColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        alignment: Alignment.bottomRight,
      ),
    );
  }
}
