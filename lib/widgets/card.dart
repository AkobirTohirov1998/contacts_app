import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

// ignore: must_be_immutable
class VCard extends VContainer {
  factory VCard.child({
    @required Widget child,
    Color background,
    AppCardStyle style,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
  }) {
    AppCardStyle cardStyle = style ?? ExampleTheme.getTheme().card_block.light;
    return VCard(
      child: child,
      background: background ?? cardStyle.background,
      width: double.infinity,
      margin: margin ?? cardStyle.margin,
      padding: padding,
      borderRadius: ExampleTheme.getTheme().card_radius,
      elevation: cardStyle.elevation,
      elevationColor: cardStyle.elevationColor,
    );
  }

  factory VCard.container({
    Widget header,
    Widget body,
    Widget footer,
    List<VButton> actions,
    bool showHeaderDivider = true,
    bool showFooterDivider = true,
    AppCardStyle style,
    Color background,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BorderRadius borderRadius,
  }) {
    AppCardStyle cardStyle = style ?? ExampleTheme.getTheme().card_block.light;

    Widget wFooter = footer;
    if (wFooter == null && actions != null && actions.isNotEmpty) {
      wFooter = Padding(
        padding: EdgeInsets.all(6),
        child: Row(
          children: actions.map((e) => Expanded(child: e)).toList(),
        ),
      );
    }
    return VCard(
      child: MyTable.vertical(
        [
          header,
          if (showHeaderDivider && header != null && body != null)
            Container(width: double.infinity, height: 0.5, color: Colors.black12),
          body,
          if (showFooterDivider && wFooter != null)
            Container(width: double.infinity, height: 0.5, color: Colors.black12),
          wFooter,
        ]..removeWhere((e) => e == null),
        width: double.infinity,
      ),
      width: double.infinity,
      margin: margin ?? cardStyle.margin,
      background: background ?? cardStyle.background,
      borderRadius: borderRadius ?? ExampleTheme.getTheme().card_radius,
      elevation: cardStyle.elevation,
      elevationColor: cardStyle.elevationColor,
    );
  }

  final Widget child;
  final double width;
  final double height;
  final Color background;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double elevation;
  final Color elevationColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  VCard({
    this.child,
    this.width,
    this.height,
    this.background,
    this.borderRadius,
    this.borderColor,
    this.elevation,
    this.elevationColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = this.child;

    widget = this.buildPadding(widget, padding);

    widget = this.buildRadius(widget, borderRadius);

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

    return widget;
  }
}

class GLCard extends VContainer {
  factory GLCard.child({
    @required Widget child,
    Color background,
    AppCardStyle style,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BorderRadius borderRadius,
  }) {
    AppCardStyle cardStyle = style ?? ExampleTheme.getTheme().card_block.glLight;
    return GLCard(
      child: child,
      background: background ?? cardStyle.background,
      width: double.infinity,
      margin: margin ?? cardStyle.margin,
      padding: padding,
      borderRadius: borderRadius ?? ExampleTheme.getTheme().card_radius,
      elevation: cardStyle.elevation,
      elevationColor: cardStyle.elevationColor,
    );
  }

  factory GLCard.container({
    Widget header,
    Widget body,
    Widget footer,
    List<GLButton> actions,
    Axis actionsDirection = Axis.horizontal,
    bool showHeaderDivider = true,
    bool showFooterDivider = true,
    AppCardStyle style,
    Color background,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BorderRadius borderRadius,
  }) {
    AppCardStyle cardStyle = style ?? ExampleTheme.getTheme().card_block.glLight;

    Widget wFooter = footer;
    if (wFooter == null && actions != null && actions.isNotEmpty) {
      if (actionsDirection == Axis.vertical) {
        wFooter = Column(children: actions);
      } else {
        wFooter = Row(children: actions.map((e) => Expanded(child: e)).toList());
      }
    }

    if (wFooter != null && actions?.isNotEmpty == true) {
      wFooter = Padding(padding: EdgeInsets.all(6), child: wFooter);
    }

    return GLCard(
      child: MyTable.vertical(
        [
          header,
          if (showHeaderDivider && header != null && body != null)
            Divider(height: 1, color: ExampleColor.getColor().border.regular_low),
          body,
          if (showFooterDivider && wFooter != null)
            Divider(height: 1, color: ExampleColor.getColor().border.regular_low),
          wFooter,
        ]..removeWhere((e) => e == null),
        width: double.infinity,
      ),
      width: double.infinity,
      margin: margin ?? cardStyle.margin,
      background: background ?? cardStyle.background,
      borderRadius: borderRadius ?? ExampleTheme.getTheme().card_radius,
      elevation: cardStyle.elevation,
      elevationColor: cardStyle.elevationColor,
    );
  }

  final Widget child;
  final double width;
  final double height;
  final Color background;
  final BorderRadius borderRadius;
  final Color borderColor;
  final double elevation;
  final Color elevationColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  GLCard({
    this.child,
    this.width,
    this.height,
    this.background,
    this.borderRadius,
    this.borderColor,
    this.elevation,
    this.elevationColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = this.child;

    widget = this.buildPadding(widget, padding);

    widget = this.buildRadius(widget, borderRadius);

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

    return widget;
  }
}
