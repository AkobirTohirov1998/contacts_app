import 'package:first_app/common/extension.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/common/lazy_stream.dart';
import 'package:gwslib/gwslib.dart';

class VItemButton {
  factory VItemButton.normal({
    IconData icon,
    String text,
    AppButtonStyle style,
    VoidCallback onTap,
    GestureTapDownCallback onTapDown,
  }) {
    return VItemButton._(
      icon: icon,
      text: text,
      isOutline: false,
      style: style,
      onTap: onTap,
      onTapDown: onTapDown,
    );
  }

  factory VItemButton.outline({
    IconData icon,
    String text,
    AppButtonStyle style,
    VoidCallback onTap,
    GestureTapDownCallback onTapDown,
  }) {
    return VItemButton._(
      icon: icon,
      text: text,
      isOutline: true,
      style: style,
      onTap: onTap,
      onTapDown: onTapDown,
    );
  }

  final IconData icon;
  final String text;
  final bool isOutline;
  final AppButtonStyle style;
  final VoidCallback onTap;
  final GestureTapDownCallback onTapDown;

  VItemButton._({
    this.icon,
    this.text,
    this.style,
    this.isOutline,
    this.onTap,
    this.onTapDown,
  });

  VButton buildButton() {
    if (isOutline) {
      return VButton.outline(
        text: text,
        icon: icon,
        style: style ?? ExampleTheme.getTheme().button_outline.defaults,
        onTap: onTap,
        onTapDown: onTapDown,
      );
    }
    return VButton.normal(
      text: text,
      icon: icon,
      style: style ?? ExampleTheme.getTheme().button_normal.primary3,
      onTap: onTap,
      onTapDown: onTapDown,
    );
  }
}

// ignore: must_be_immutable
@Deprecated('Use GLItem')
class VItem extends VContainer {
  factory VItem.withStyle({
    AppItemStyle style,
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<VItemButton> actions,
  }) {
    final cStyle = style ?? ExampleTheme.getTheme().item.defaults;
    return VItem(
      icon: icon,
      iconColor: iconColor ?? cStyle.iconColor,
      iconWidget: iconWidget,
      rightIcon: rightIcon,
      rightIconColor: rightIconColor ?? cStyle.iconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      radioLeft: radioLeft,
      title: title,
      titleStyle: titleStyle,
      titleColor: titleColor ?? cStyle.titleColor,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      subtitleColor: subtitleColor ?? cStyle.subtitleColor,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleStyle2: subtitleStyle2,
      subtitleColor2: subtitleColor2 ?? cStyle.subtitleColor,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor ?? cStyle.infoColor,
      infoWidget: infoWidget,
      background: background ?? cStyle.background,
      verticalDivider: verticalDivider ?? false,
      flex: flex,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory VItem.checkbox({
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<VItemButton> actions,
  }) {
    return VItem.withStyle(
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory VItem.radio({
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<VItemButton> actions,
  }) {
    return VItem.withStyle(
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      radioLeft: radioLeft,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory VItem.build({
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<VItemButton> actions,
  }) {
    return VItem.withStyle(
      icon: icon,
      iconColor: iconColor,
      iconWidget: iconWidget,
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      radioStream: radioStream,
      radioValue: radioValue,
      radioLeft: radioLeft,
      onRadioChange: onRadioChange,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  final IconData icon;
  final Color iconColor;
  final Widget iconWidget;
  final IconData rightIcon;
  final Color rightIconColor;
  final Widget rightIconWidget;
  final bool enableCheckbox;
  final VoidCheckboxChange onCheckboxChange;
  final bool checkboxLeft;
  final bool cupertinoSwitch;
  final bool enableRadio;
  final int radioValue;
  final VoidRadioChange onRadioChange;
  final bool radioLeft;
  final String title;
  final TextStyle titleStyle;
  final Color titleColor;
  final Widget titleWidget;
  final String subtitle;
  final TextStyle subtitleStyle;
  final Color subtitleColor;
  final Widget subtitleWidget;
  final String subtitle2;
  final TextStyle subtitleStyle2;
  final Color subtitleColor2;
  final Widget subtitleWidget2;
  final String info;
  final TextStyle infoStyle;
  final Color infoColor;
  final Widget infoWidget;
  final bool verticalDivider;
  final int flex;
  final Color background;
  final VoidCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final List<VButton> actions;

  VItem({
    this.icon,
    this.iconColor,
    this.iconWidget,
    this.rightIcon,
    this.rightIconColor,
    this.rightIconWidget,
    Stream<bool> checkboxStream,
    this.onCheckboxChange,
    this.checkboxLeft,
    this.cupertinoSwitch,
    Stream<int> radioStream,
    this.onRadioChange,
    this.radioValue,
    this.radioLeft,
    this.title,
    this.titleStyle,
    this.titleColor,
    this.titleWidget,
    this.subtitle,
    this.subtitleStyle,
    this.subtitleColor,
    this.subtitleWidget,
    this.subtitle2,
    this.subtitleStyle2,
    this.subtitleColor2,
    this.subtitleWidget2,
    this.info,
    this.infoStyle,
    this.infoColor,
    this.infoWidget,
    this.verticalDivider,
    this.flex,
    this.background,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    List<VItemButton> actions,
  })  : enableCheckbox = checkboxStream != null,
        enableRadio = radioStream != null,
        actions = actions?.map((e) => e.buildButton())?.toList() {
    checkboxStream?.listen((value) {
      if (value != check.value) {
        check.add(value);
      }
    });

    radioStream?.listen((value) {
      if (value != radio.value) {
        radio.add(value);
      }
    });
  }

  final LazyStream<bool> check = LazyStream(() => false);
  final LazyStream<int> radio = LazyStream(() => -1);

  @override
  void onDestroy() {
    check.close();
    radio.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    Widget wIcon = iconWidget;
    if (wIcon == null && icon != null) {
      wIcon = Icon(icon, size: 20, color: iconColor);
    }

    if (wIcon != null) {
      wIcon = Padding(padding: const EdgeInsets.only(right: 12), child: wIcon);
    }

    Widget wRightIcon = rightIconWidget;
    if (wRightIcon == null && rightIcon != null) {
      wRightIcon = Icon(rightIcon, size: 20, color: rightIconColor);
    }

    if (wRightIcon != null) {
      wRightIcon = Padding(padding: const EdgeInsets.only(left: 12), child: wRightIcon);
    }

    if (enableCheckbox) {
      final checkbox = Theme(
        data: ThemeData(unselectedWidgetColor: titleColor),
        child: StreamBuilder<bool>(
          stream: this.check.stream,
          initialData: this.check.value,
          builder: (_, st) {
            final value = st.data ?? false;
            if (this.cupertinoSwitch == true) {
              return Transform.scale(
                scale: 0.75,
                child: CupertinoSwitch(
                  activeColor: ExampleColor.getColor().status.success,
                  trackColor: ExampleColor.getColor().status.error,
                  value: value,
                  onChanged: (value) {
                    this.check.add(value);
                    this.onCheckboxChange?.call(value);
                  },
                ),
              );
            }
            return Checkbox(
              activeColor: ExampleColor.getColor().primary.primary_1,
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

      if (this.checkboxLeft) {
        wIcon = checkbox;
      } else {
        wRightIcon = checkbox;
      }
    } else if (this.enableRadio) {
      final checkbox = Theme(
        data: ThemeData(unselectedWidgetColor: this.titleColor),
        child: new StreamBuilder<int>(
          stream: this.radio.stream,
          initialData: this.radio.value,
          builder: (_, st) {
            final value = st.data ?? -1;
            return new Radio<int>(
              value: this.radioValue,
              groupValue: value,
              onChanged: (value) {
                this.radio.add(this.radioValue);
                this.onRadioChange?.call(this.radioValue);
              },
            );
          },
        ),
      );

      if (this.radioLeft) {
        wIcon = checkbox;
      } else {
        wRightIcon = checkbox;
      }
    }

    Widget wTitle = this.titleWidget;
    if (wTitle == null && this.title != null) {
      wTitle = MyText(
        this.title,
        style:
            this.titleStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: this.titleColor),
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
      wSubtitle = Padding(padding: EdgeInsets.only(top: 2), child: wSubtitle);
    }

    Widget wSubtitle2 = this.subtitleWidget2;
    if (wSubtitle2 == null && this.subtitle2 != null) {
      wSubtitle2 = MyText(
        this.subtitle2,
        style: this.subtitleStyle2 ??
            ExampleTheme.getTheme().textStyle.caption(color: this.subtitleColor2),
        textOverflow: TextOverflow.ellipsis,
      );
    }
    if (wSubtitle2 != null) {
      wSubtitle2 = Padding(padding: EdgeInsets.only(top: 2), child: wSubtitle2);
    }

    Widget wInfo = this.infoWidget;
    if (wInfo == null && this.info != null) {
      wInfo = MyText(
        this.info,
        style: this.infoStyle ?? ExampleTheme.getTheme().textStyle.caption(color: this.infoColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }

    Widget widget = Row(
      children: [
        if (wIcon != null) wIcon,
        Expanded(
          child: Column(
            children: [
              Row(children: [
                if (wTitle != null) Expanded(child: wTitle),
                if (wInfo != null) wInfo,
              ]),
              wSubtitle,
              wSubtitle2,
            ]..removeWhere((e) => e == null),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
        if (wRightIcon != null) wRightIcon,
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );

    if ((this.enableCheckbox && this.checkboxLeft) || (this.enableRadio && this.radioLeft)) {
      widget = super.buildPadding(widget, EdgeInsets.only(right: 12, top: 8, bottom: 8));
    } else {
      if ((this.enableCheckbox && !this.checkboxLeft) || (this.enableRadio && !this.radioLeft)) {
        widget = super.buildPadding(widget, EdgeInsets.only(left: 12, top: 8, bottom: 8));
      } else {
        widget =
            super.buildPadding(widget, EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8));
      }
    }

    widget = super.buildOnTap(widget, onTap, onDoubleTap: onDoubleTap, onLongPress: onLongPress);

    widget = Container(
      child: widget,
      constraints: BoxConstraints(minHeight: 56),
      color: this.background,
    );

    if (verticalDivider == true) {
      widget = Container(
        child: Padding(
          padding: EdgeInsets.only(top: 0.5),
          child: widget,
        ),
        color: Colors.black12,
      );
    }

    widget = super.buildExpanded(widget, this.flex);

    return widget;
  }
}

class GLItemButton {
  factory GLItemButton.normal({
    IconData icon,
    String text,
    AppButtonStyle style,
    VoidCallback onTap,
    GestureTapDownCallback onTapDown,
  }) {
    return GLItemButton._(
      icon: icon,
      text: text,
      style: style,
      onTap: onTap,
      onTapDown: onTapDown,
    );
  }

  final IconData icon;
  final String text;
  final AppButtonStyle style;
  final VoidCallback onTap;
  final GestureTapDownCallback onTapDown;

  GLItemButton._({
    this.icon,
    this.text,
    this.style,
    this.onTap,
    this.onTapDown,
  });

  GLButton buildButton() {
    return GLButton.regular(
      text: this.text,
      icon: this.icon,
      style: this.style ?? ExampleTheme.getTheme().button_normal.regular,
      onTap: this.onTap,
      onTapDown: onTapDown,
      margin: EdgeInsets.zero,
    );
  }
}

class GLItem extends VContainer {
  factory GLItem.withStyle({
    AppItemStyle style,
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    bool checkboxTristate = false,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<GLItemButton> actions,
  }) {
    final cStyle = style ?? ExampleTheme.getTheme().item.regular;
    return GLItem(
      icon: icon,
      iconColor: iconColor ?? cStyle.iconColor,
      iconWidget: iconWidget,
      rightIcon: rightIcon,
      rightIconColor: rightIconColor ?? cStyle.iconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      checkboxTristate: checkboxTristate,
      onCheckboxChange: onCheckboxChange,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      radioLeft: radioLeft,
      title: title,
      titleStyle: titleStyle,
      titleColor: titleColor ?? cStyle.titleColor,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleStyle: subtitleStyle,
      subtitleColor: subtitleColor ?? cStyle.subtitleColor,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleStyle2: subtitleStyle2,
      subtitleColor2: subtitleColor2 ?? cStyle.subtitleColor,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor ?? cStyle.infoColor,
      infoWidget: infoWidget,
      background: background ?? cStyle.background,
      verticalDivider: verticalDivider ?? false,
      flex: flex,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory GLItem.checkbox({
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    bool checkboxTristate = false,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<GLItemButton> actions,
  }) {
    return GLItem.withStyle(
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      onCheckboxChange: onCheckboxChange,
      checkboxTristate: checkboxTristate,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory GLItem.radio({
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<GLItemButton> actions,
  }) {
    return GLItem.withStyle(
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      radioStream: radioStream,
      radioValue: radioValue,
      onRadioChange: onRadioChange,
      radioLeft: radioLeft,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  factory GLItem.build({
    IconData icon,
    Color iconColor,
    Widget iconWidget,
    IconData rightIcon,
    Color rightIconColor,
    Widget rightIconWidget,
    Stream<bool> checkboxStream,
    bool checkboxTristate,
    VoidCheckboxChange onCheckboxChange,
    bool checkboxLeft = true,
    bool cupertinoSwitch = true,
    Stream<int> radioStream,
    VoidRadioChange onRadioChange,
    int radioValue,
    bool radioLeft = true,
    String title,
    Color titleColor,
    TextStyle titleStyle,
    Widget titleWidget,
    String subtitle,
    Color subtitleColor,
    TextStyle subtitleStyle,
    Widget subtitleWidget,
    String subtitle2,
    Color subtitleColor2,
    TextStyle subtitleStyle2,
    Widget subtitleWidget2,
    String info,
    TextStyle infoStyle,
    Color infoColor,
    Widget infoWidget,
    bool verticalDivider,
    int flex,
    Color background,
    VoidCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
    List<GLItemButton> actions,
  }) {
    return GLItem.withStyle(
      icon: icon,
      iconColor: iconColor,
      iconWidget: iconWidget,
      rightIcon: rightIcon,
      rightIconColor: rightIconColor,
      rightIconWidget: rightIconWidget,
      checkboxStream: checkboxStream,
      checkboxTristate: checkboxTristate,
      onCheckboxChange: onCheckboxChange,
      checkboxLeft: checkboxLeft,
      cupertinoSwitch: cupertinoSwitch,
      radioStream: radioStream,
      radioValue: radioValue,
      radioLeft: radioLeft,
      onRadioChange: onRadioChange,
      title: title,
      titleColor: titleColor,
      titleStyle: titleStyle,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleColor: subtitleColor,
      subtitleStyle: subtitleStyle,
      subtitleWidget: subtitleWidget,
      subtitle2: subtitle2,
      subtitleColor2: subtitleColor2,
      subtitleStyle2: subtitleStyle2,
      subtitleWidget2: subtitleWidget2,
      info: info,
      infoStyle: infoStyle,
      infoColor: infoColor,
      infoWidget: infoWidget,
      verticalDivider: verticalDivider,
      flex: flex,
      background: background,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      actions: actions,
    );
  }

  final IconData icon;
  final Color iconColor;
  final Widget iconWidget;
  final IconData rightIcon;
  final Color rightIconColor;
  final Widget rightIconWidget;
  final bool enableCheckbox;
  final VoidCheckboxChange onCheckboxChange;
  final bool checkboxLeft;
  final bool checkboxTristate;
  final bool cupertinoSwitch;
  final bool enableRadio;
  final int radioValue;
  final VoidRadioChange onRadioChange;
  final bool radioLeft;
  final String title;
  final TextStyle titleStyle;
  final Color titleColor;
  final Widget titleWidget;
  final String subtitle;
  final TextStyle subtitleStyle;
  final Color subtitleColor;
  final Widget subtitleWidget;
  final String subtitle2;
  final TextStyle subtitleStyle2;
  final Color subtitleColor2;
  final Widget subtitleWidget2;
  final String info;
  final TextStyle infoStyle;
  final Color infoColor;
  final Widget infoWidget;
  final bool verticalDivider;
  final int flex;
  final Color background;
  final VoidCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final List<GLButton> actions;

  GLItem({
    this.icon,
    this.iconColor,
    this.iconWidget,
    this.rightIcon,
    this.rightIconColor,
    this.rightIconWidget,
    Stream<bool> checkboxStream,
    this.onCheckboxChange,
    this.checkboxLeft,
    this.checkboxTristate = false,
    this.cupertinoSwitch,
    Stream<int> radioStream,
    this.onRadioChange,
    this.radioValue,
    this.radioLeft,
    this.title,
    this.titleStyle,
    this.titleColor,
    this.titleWidget,
    this.subtitle,
    this.subtitleStyle,
    this.subtitleColor,
    this.subtitleWidget,
    this.subtitle2,
    this.subtitleStyle2,
    this.subtitleColor2,
    this.subtitleWidget2,
    this.info,
    this.infoStyle,
    this.infoColor,
    this.infoWidget,
    this.verticalDivider,
    this.flex,
    this.background,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    List<GLItemButton> actions,
  })  : this.enableCheckbox = checkboxStream != null,
        this.enableRadio = radioStream != null,
        this.actions = actions?.map((e) => e.buildButton())?.toList() {
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
      wIcon = Container(child: Icon(icon, size: 24, color: iconColor), width: 40, height: 40);
    }

    if (wIcon != null) {
      wIcon = Padding(padding: EdgeInsets.only(right: 8), child: wIcon);
    }

    Widget wRightIcon = this.rightIconWidget;
    if (wRightIcon == null && this.rightIcon != null) {
      wRightIcon = Container(
          child: Icon(
            rightIcon,
            size: 24,
            color: rightIconColor,
          ),
          height: 40,
          width: 40);
    }

    if (wRightIcon != null) {
      wRightIcon = Padding(padding: EdgeInsets.only(left: 8), child: wRightIcon);
    }

    if (this.enableCheckbox) {
      final checkbox = Theme(
        data: ThemeData(unselectedWidgetColor: this.titleColor),
        child: new StreamBuilder<bool>(
          stream: this.check.stream,
          initialData: this.check.value,
          builder: (_, st) {
            final value = st.data ?? false;
            if (this.cupertinoSwitch == true) {
              return Transform.scale(
                scale: 0.75,
                child: CupertinoSwitch(
                  activeColor: ExampleColor.getColor().accent,
                  trackColor: ExampleColor.getColor().block.background,
                  value: value,
                  onChanged: (value) {
                    this.check.add(value);
                    this.onCheckboxChange?.call(value);
                  },
                ),
              );
            }
            return Checkbox(
              tristate: this.checkboxTristate ?? false,
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

      if (this.checkboxLeft) {
        wIcon = checkbox;
      } else {
        wRightIcon = checkbox;
      }
    } else if (this.enableRadio) {
      final checkbox = Theme(
        data: ThemeData(unselectedWidgetColor: this.titleColor),
        child: new StreamBuilder<int>(
          stream: this.radio.stream,
          initialData: this.radio.value,
          builder: (_, st) {
            final value = st.data ?? -1;
            return new Radio<int>(
              value: this.radioValue,
              groupValue: value,
              onChanged: (value) {
                this.radio.add(this.radioValue);
                this.onRadioChange?.call(this.radioValue);
              },
            );
          },
        ),
      );

      if (this.radioLeft) {
        wIcon = checkbox;
      } else {
        wRightIcon = checkbox;
      }
    }

    Widget wTitle = this.titleWidget;
    if (wTitle == null && this.title?.isNotEmpty == true) {
      wTitle = MyText(
        this.title,
        style: this.titleStyle ?? ExampleTheme.getTheme().textStyle.body(color: this.titleColor),
        textOverflow: TextOverflow.clip,
      );
    }

    Widget wSubtitle = this.subtitleWidget;
    if (wSubtitle == null && this.subtitle?.isNotEmpty == true) {
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

    Widget wSubtitle2 = this.subtitleWidget2;
    if (wSubtitle2 == null && this.subtitle2?.isNotEmpty == true) {
      wSubtitle2 = MyText(
        this.subtitle2,
        style: this.subtitleStyle2 ??
            ExampleTheme.getTheme().textStyle.caption(color: this.subtitleColor2),
        textOverflow: TextOverflow.ellipsis,
      );
    }
    if (wSubtitle2 != null) {
      wSubtitle2 = Padding(padding: EdgeInsets.only(top: 4), child: wSubtitle2);
    }

    Widget wInfo = this.infoWidget;
    if (wInfo == null && this.info != null) {
      wInfo = MyText(
        this.info,
        style: this.infoStyle ?? ExampleTheme.getTheme().textStyle.caption(color: this.infoColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }

    Widget widget = Row(
      children: [
        if (wIcon != null) wIcon,
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (wTitle != null) Expanded(child: wTitle),
                  if (wInfo != null) wInfo,
                ],
              ),
              wSubtitle,
              wSubtitle2,
            ]..removeWhere((e) => e == null),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        if (actions != null && actions.isNotEmpty)
          Row(
              children: [SizedBox(width: 4)]
                ..addAll(actions.map((e) => e).toList().joinWithWidget(SizedBox(width: 4)))),
        if (wRightIcon != null) wRightIcon,
      ],
      crossAxisAlignment: wSubtitle != null || wSubtitle2 != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
    EdgeInsets padding = EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16);

    if (wIcon != null) {
      padding = EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 16);
    }
    if (wRightIcon != null || actions?.isNotEmpty == true) {
      padding = EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 8);
    }

    if (wIcon != null && (wRightIcon != null || actions?.isNotEmpty == true)) {
      padding = EdgeInsets.all(8);
    }
    widget = super.buildPadding(widget, padding);

    widget = super.buildOnTap(widget, onTap, onDoubleTap: onDoubleTap, onLongPress: onLongPress);

    widget = Container(
      child: widget,
      constraints: BoxConstraints(minHeight: 56),
      color: this.background,
      alignment: Alignment.center,
    );

    if (verticalDivider == true) {
      widget = Container(
        child: Padding(
          padding: EdgeInsets.only(top: 0.65),
          child: widget,
        ),
        color: ExampleColor.getColor().border.regular_low,
      );
    }

    widget = super.buildExpanded(widget, this.flex);

    return widget;
  }
}
