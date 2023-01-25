import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

typedef TagTapHandler = void Function(dynamic value);

typedef CheckBoxChangedValue = void Function(bool value);

// ignore: must_be_immutable
class GLTag extends VContainer {
  dynamic value;
  bool enableCheckbox;
  bool checkboxValue;
  ValueChanged<bool> checkboxValueChanged;
  AppButtonStyle intlStyle;
  AppButtonStyle activeStyle;
  double height;
  Widget titleWidget;
  TextStyle textStyle;
  String title;
  Widget iconWidget;
  IconData icon;
  BorderRadius borderRadius;
  TagTapHandler tapHandler;

  LazyStream<bool> _checkboxValue = LazyStream(() => false);
  LazyStream<AppButtonStyle> _style = LazyStream(() => null);

  GLTag({
    this.enableCheckbox,
    this.checkboxValue,
    this.checkboxValueChanged,
    this.intlStyle,
    this.activeStyle,
    this.icon,
    this.iconWidget,
    this.title,
    this.titleWidget,
    this.textStyle,
    this.tapHandler,
    double height,
    this.value,
    this.borderRadius,
  })  : assert(
            iconWidget != null || titleWidget != null || icon != null || title?.isNotEmpty == true),
        this.height = height ?? 24 {
    _checkboxValue.add(checkboxValue == true);
    reloadStyle();
  }

  void reloadStyle() {
    if (_checkboxValue.value == true)
      _style.add(activeStyle);
    else
      _style.add(intlStyle);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return StreamBuilder<AppButtonStyle>(
      stream: _style.stream,
      builder: (context, snapshot) {
        AppButtonStyle style = snapshot?.data ?? this.intlStyle;
        Widget widget = Row(
          children: [getIconWidget(style), getTitleWidget(style)].where((e) => e != null).toList(),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        );

        widget = Container(
          child: widget,
          height: height,
          decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
              color: style?.background,
              border: Border.all(color: style.background)),
          padding: EdgeInsets.symmetric(horizontal: 8),
        );

        widget = InkWell(
            child: widget,
            onTap: () {
              checkboxValueChanged?.call(!_checkboxValue.value);
              changeStyle();
            });
        return widget;
      },
    );
  }

  void changeStyle() {
    _checkboxValue.add(!_checkboxValue.value);
    tapHandler?.call(value);
    reloadStyle();
  }

  Widget getIconWidget(AppButtonStyle style) {
    Widget wIcon = iconWidget;
    if (wIcon == null && icon != null) {
      wIcon = MyIcon.icon(
        icon,
        color: style?.iconColor,
        alignment: Alignment.center,
        size: 16,
      );
    }

    if (enableCheckbox == true) {
      wIcon = StreamBuilder(
          stream: _checkboxValue.stream,
          builder: (context, snapshot) {
            return Container(
              child: Checkbox(
                checkColor: style.background,
                fillColor: MaterialStateColor.resolveWith((states) => style.iconColor),
                value: snapshot.data == true,
                onChanged: (value) {
                  checkboxValueChanged?.call(!_checkboxValue.value);
                  changeStyle();
                },
              ),
              width: height - 4,
            );
          });
    }
    return wIcon;
  }

  Widget getTitleWidget(AppButtonStyle style) {
    Widget wTitle = titleWidget;
    if (wTitle == null && title?.isNotEmpty == true) {
      wTitle = Text(
        title,
        style: textStyle ?? ExampleTheme.getTheme().textStyle.body(color: style.textColor),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );
    }
    return wTitle;
  }
}
