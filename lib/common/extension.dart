import 'package:flutter/material.dart';

extension WidgetListMap on List<Widget> {
  List<Widget> joinWithWidget(Widget widget) {
    if (isEmpty || length < 2) return this;
    List<Widget> widgets = [first, widget];
    for (int i = 1; i < length - 1; i++) {
      widgets.addAll([this[i], widget]);
    }
    widgets.addAll([last]);
    return widgets;
  }
}
