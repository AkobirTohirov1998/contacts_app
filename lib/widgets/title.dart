import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class VTitleButton {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final GestureTapDownCallback onTapDown;

  VTitleButton({this.icon, this.text, this.onTap, this.onTapDown});
}

// ignore: must_be_immutable
class VTitle extends VContainer {
  factory VTitle.withStyle({
    AppTitleStyle style,
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    String title,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    List<VTitleButton> actions,
  }) {
    return VTitle(
      icon: icon,
      iconColor: iconColor ?? style.iconColor,
      iconWidget: iconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      title: title,
      titleStyle: titleStyle,
      titleColor: style.titleColor,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      subtitleColor: style.subtitleColor,
      subtitleWidget: subtitleWidget,
      background: style.background,
      actions: actions
          ?.map((e) => VButton.outline(
                text: e.text,
                icon: e.icon,
                style: style.buttonStyle,
                onTap: e.onTap,
                onTapDown: e.onTapDown,
              ))
          ?.toList(),
    );
  }

  factory VTitle.light({
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    String title,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    List<VTitleButton> actions,
  }) {
    return VTitle.withStyle(
      style: ExampleTheme.getTheme().title.light,
      icon: icon,
      iconColor: iconColor,
      iconWidget: iconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      title: title,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      actions: actions,
    );
  }

  factory VTitle.dark({
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    String title,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    List<VTitleButton> actions,
  }) {
    return VTitle.withStyle(
      style: ExampleTheme.getTheme().title.dark,
      icon: icon,
      iconColor: iconColor,
      iconWidget: iconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      title: title,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      actions: actions,
    );
  }

  final IconData icon;
  final Color iconColor;
  final Widget iconWidget;
  final bool enableCheckbox;
  final VoidCheckboxChange onCheckboxChange;
  final bool enableRadio;
  final int radioValue;
  final VoidRadioChange onRadioChange;
  final String title;
  final TextStyle titleStyle;
  final Color titleColor;
  final Widget titleWidget;
  final String subtitle;
  final TextStyle subtitleStyle;
  final Color subtitleColor;
  final Widget subtitleWidget;
  final Color background;
  final List<VButton> actions;

  VTitle({
    this.icon,
    this.iconColor,
    this.iconWidget,
    Stream<bool> checkboxStream,
    this.onCheckboxChange,
    Stream<int> radioStream,
    this.onRadioChange,
    this.radioValue,
    this.title,
    this.titleStyle,
    this.titleColor,
    this.titleWidget,
    this.subtitle,
    this.subtitleStyle,
    this.subtitleColor,
    this.subtitleWidget,
    this.background,
    this.actions,
  })  : this.enableCheckbox = checkboxStream != null,
        this.enableRadio = radioStream != null {
    checkboxStream?.listen((value) {
      if (value != this.check.value) {
        this.check.add(value);
      }
    });

    radioStream?.listen((value) {
      if (value != this.radio.value) {
        this.radio.add(value);
      }
    });
  }

  final LazyStream<bool> check = new LazyStream(() => false);
  final LazyStream<int> radio = new LazyStream(() => -1);

  @override
  void onDestroy() {
    this.check.close();
    this.radio.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    Widget wIcon = this.iconWidget;
    if (wIcon == null && this.icon != null) {
      wIcon = Icon(icon, size: 20, color: iconColor);
    }

    if (wIcon != null) {
      wIcon = Padding(padding: EdgeInsets.only(left: 12), child: wIcon);
    }

    if (enableCheckbox) {
      wIcon = Theme(
        data: ThemeData(unselectedWidgetColor: this.titleColor),
        child: StreamBuilder<bool>(
          stream: this.check.stream,
          initialData: this.check.value,
          builder: (_, st) {
            final value = st.data ?? false;
            return Checkbox(
              activeColor: ExampleColor.getColor().accent,
              checkColor: ExampleColor.getColor().text.on_primary_high_emphasis,
              value: value,
              onChanged: (value) {
                this.check.add(value);
                this.onCheckboxChange?.call(value);
              },
            );
          },
        ),
      );
    } else if (enableRadio) {
      wIcon = Theme(
        data: ThemeData(unselectedWidgetColor: this.titleColor),
        child: StreamBuilder<int>(
          stream: this.radio.stream,
          initialData: this.radio.value,
          builder: (_, st) {
            final value = st.data ?? -1;
            return Radio<int>(
              value: radioValue,
              groupValue: value,
              onChanged: (value) {
                radio.add(radioValue);
                onRadioChange?.call(radioValue);
              },
            );
          },
        ),
      );
    }

    Widget wTitle = this.titleWidget;
    if (wTitle == null && this.title != null) {
      wTitle = MyText(
        this.title,
        style: this.titleStyle ?? ExampleTheme.getTheme().textStyle.title_5(color: this.titleColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }

    Widget wSubtitle = this.subtitleWidget;
    if (wSubtitle == null && this.subtitle != null) {
      wSubtitle = MyText(
        this.subtitle,
        style: this.subtitleStyle ??
            ExampleTheme.getTheme().textStyle.caption(color: this.subtitleColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }
    if (wSubtitle != null) {
      wSubtitle = Padding(padding: EdgeInsets.only(top: 4), child: wSubtitle);
    }

    return Container(
      child: Row(
        children: [
          if (wIcon != null) wIcon,
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: (this.enableCheckbox || this.enableRadio) ? 0 : 12,
                right: 12,
              ),
              child: Column(
                children: [wTitle, wSubtitle]..removeWhere((e) => e == null),
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
          if (actions != null && actions.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Row(
                children: actions
                    .map((e) => Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: e,
                        ))
                    .toList(),
              ),
            ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      height: 56,
      color: this.background,
    );
  }
}
