import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

typedef VoidRadioChange = void Function(int value);
typedef VoidCheckboxChange = void Function(bool value);

// ignore: must_be_immutable
class VContainer extends MoldStatefulWidget {
  Widget buildBox(
    Widget widget,
    double width,
    double height,
    Color color,
    BorderRadius borderRadius,
    Color borderColor,
    double elevation,
    Color elevationColor, [
    Offset elevationOffset,
    EdgeInsets padding,
  ]) {
    if (color == null) {
      return widget;
    }

    List<BoxShadow> boxShadow = [];
    bool hasElevation = elevation != null && elevation > 0.0;
    if (hasElevation) {
      boxShadow.add(BoxShadow(
        color: elevationColor,
        offset: elevationOffset ?? Offset(0, 3),
        blurRadius: elevation,
      ));
    }

    final border = borderColor == null ? null : Border.all(color: borderColor);
    final decorator = BoxDecoration(
      border: border,
      borderRadius: borderRadius,
      color: color,
      boxShadow: boxShadow,
    );

    return Container(
      width: width,
      height: height,
      child: widget,
      decoration: decorator,
      padding: padding,
    );
  }

  Widget buildRadius(Widget widget, BorderRadius borderRadius) {
    if (borderRadius == null) {
      return widget;
    }
    return ClipRRect(child: widget, borderRadius: borderRadius);
  }

  Widget buildPadding(Widget widget, EdgeInsetsGeometry padding) {
    if (padding == null) {
      return widget;
    }
    return Padding(padding: padding, child: widget);
  }

  Widget buildOnTap(
    Widget widget,
    VoidCallback onTap, {
    GestureTapDownCallback onTapDown,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    if (onTap != null||onTapDown!=null||onDoubleTap!=null||onLongPress!=null) {
      widget = Material(
        color: Colors.transparent,
        child: InkWell(
          child: widget,
          borderRadius: borderRadius,
          onTap: onTap,
          onTapDown: onTapDown,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
        ),
      );
    }
    return widget;
  }

  Widget buildExpanded(Widget widget, int flex) {
    if (flex == null) {
      return widget;
    }
    return Expanded(child: widget, flex: flex);
  }

  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return this.build(context);
  }
}
