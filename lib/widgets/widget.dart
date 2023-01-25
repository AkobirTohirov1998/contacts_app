import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VWidget extends VContainer {
  final Widget child;
  final double width;
  final double height;
  final int flex;
  final Color background;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;

  final Color borderColor;
  final double elevation;
  final Color elevationColor;

  VWidget({
    this.child,
    this.width,
    this.height,
    this.flex,
    this.background,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onTap,
    this.onTapDown,
    this.borderColor,
    this.elevation,
    this.elevationColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = child ?? Container();

    widget = buildPadding(widget, padding);
    widget = buildOnTap(widget, onTap, onTapDown: onTapDown);
    widget = buildBox(
      widget,
      width,
      height,
      background,
      borderRadius,
      borderColor,
      elevation,
      elevationColor,
    );
    widget = buildPadding(widget, margin);

    return widget;
  }
}
