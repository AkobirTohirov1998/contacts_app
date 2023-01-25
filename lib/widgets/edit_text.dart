import 'package:first_app/common/emoji.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:first_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/gwslib.dart';

import '../resources/theme.dart';

// ignore: must_be_immutable
class VEditText extends VContainer {
  final String text;
  final TextStyle textStyle;
  final AppEditTextStyle style;
  final bool enabled;
  final bool autofocus;
  final Iterable<String> autoFillHints;
  final int lines;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;

  //
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;
  final String helperText;
  final TextStyle helperStyle;
  final Widget helperWidget;

  //
  final String errorText;
  final TextStyle errorStyle;
  final Widget errorWidget;
  final String successText;
  final TextStyle successStyle;
  final Widget successWidget;

  //
  final String prefixText;
  final TextStyle prefixStyle;
  final String suffixText;
  final TextStyle suffixStyle;
  final String counterText;

  //
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final bool obscureText;

  //
  final IconData leftIcon;
  final Widget leftWidget;
  final GestureTapCallback onLeftTap;

  //
  final IconData rightIcon;
  final IconData rightIconButton;
  final Widget rightWidget;
  final GestureTapCallback onRightTap;

  //
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry margin;
  final ValueChanged<String> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;

  VEditText({
    this.text,
    this.textStyle,
    this.enabled = true,
    this.autofocus = false,
    this.autoFillHints,
    this.focusNode,
    this.lines,
    this.minLines,
    this.maxLines,
    this.maxLength,
    TextEditingController textController,
    this.style,
    //
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    //
    this.helperText,
    this.helperStyle,
    this.helperWidget,
    //
    bool error = false,
    Stream<bool> errorStream,
    this.errorText,
    this.errorStyle,
    this.errorWidget,
    bool success = false,
    Stream<bool> successStream,
    this.successText,
    this.successStyle,
    this.successWidget,
    //
    this.prefixText,
    this.prefixStyle,
    this.suffixText,
    this.suffixStyle,
    //
    this.counterText,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.obscureText,
    //
    this.leftIcon,
    this.leftWidget,
    this.onLeftTap,
    this.rightIcon,
    this.rightIconButton,
    this.rightWidget,
    //
    this.onRightTap,
    this.borderRadius,
    this.margin,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
  }) : this.textController = textController ?? TextEditingController() {
    if (text != null && text.isNotEmpty) {
      this.textController.text = text;
    }

    if (maxLength != null && maxLength > 0) {
      this.textController.addListener(() {
        _currentLength.add(this.textController.text.length);
      });
    }

    _style.add(style);

    _success.add(success == true || Util.nonEmpty(successText) || successWidget != null);
    _error.add(error == true || Util.nonEmpty(errorText) || errorWidget != null);

    successStream?.listen((event) {
      _success.add(event ?? false);
    });

    errorStream?.listen((event) {
      _error.add(event ?? false);
    });

    focusNode?.addListener(() => reloadStyle());

    _success.stream.listen((event) => reloadStyle());
    _error.stream.listen((event) => reloadStyle());

    reloadStyle();
  }

  static Widget customEditText({
    String hintText,
    String text,
    String labelText,
    TextStyle textStyle,
    TextStyle labelStyle,
    TextEditingController textController,
    AppEditTextStyle style,
    EdgeInsets margin,
    EdgeInsets padding,
    double height,
    bool enabled = true,
    TextInputType keyboardType,
    BorderRadius borderRadius,
    void Function(String text) onChanged,
  }) {
    textController ??= TextEditingController(text: text);

    style ??= ExampleTheme.getTheme().edittext.defaults;

    final inputDecorator = InputDecoration(
      isDense: true,
      border: InputBorder.none,
      labelStyle:
          labelStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.labelTextColor),
      hintStyle: ExampleTheme.getTheme().textStyle.paragraph(color: style.hintTextColor),
      hintText: hintText,
      labelText: labelText,
      contentPadding: EdgeInsets.only(right: 8),
    );

    final inputTextField = TextFormField(
      decoration: inputDecorator,
      controller: textController,
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: textStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.textColor),
      obscureText: false,
      onChanged: onChanged,
      enabled: enabled,
    );

    return VWidget(
      width: double.infinity,
      height: height ?? 56,
      child: Container(alignment: Alignment.center, child: inputTextField),
      background: style.background,
      borderRadius: borderRadius ?? ExampleTheme.getTheme().edittext_radius,
      borderColor: style.borderColor,
      margin: margin ?? const EdgeInsets.all(4),
      padding: padding ?? const EdgeInsets.only(left: 5),
    );
  }

  static Widget searchField({
    String hintText,
    String text,
    TextEditingController textController,
    AppEditTextStyle style,
    EdgeInsets margin,
    BorderRadius borderRadius,
    bool autofocus = true,
    void Function(String text) onChanged,
    IconData rightIcon,
    void Function() onRightTap,
  }) {
    textController ??= TextEditingController(text: text);

    style ??= ExampleTheme.getTheme().edittext.defaults;

    final inputDecorator = InputDecoration(
      isDense: true,
      border: InputBorder.none,
      icon: MyIcon.icon(Icons.search,
          padding: const EdgeInsets.only(left: 10), color: style.hintTextColor, size: 20),
      suffixIcon: (rightIcon != null && onRightTap != null)
          ? IconButton(
              onPressed: onRightTap, icon: Icon(rightIcon, color: style.hintTextColor, size: 20))
          : null,
      labelStyle: ExampleTheme.getTheme().textStyle.paragraph(color: style.labelTextColor),
      hintStyle: ExampleTheme.getTheme().textStyle.paragraph(color: style.hintTextColor),
      hintText: hintText,
      contentPadding: const EdgeInsets.only(right: 8),
    );

    final inputTextField = TextFormField(
      decoration: inputDecorator,
      controller: textController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      style: ExampleTheme.getTheme().textStyle.paragraph(color: style.textColor),
      obscureText: false,
      onChanged: onChanged,
      autofocus: autofocus,
    );

    return VWidget(
      width: double.infinity,
      height: 45,
      child: Container(alignment: Alignment.center, child: inputTextField),
      background: style.background,
      borderRadius: borderRadius ?? ExampleTheme.getTheme().edittext_radius,
      borderColor: style.borderColor,
      margin: margin ?? const EdgeInsets.all(4),
    );
  }

  final FocusNode focusNode;
  final LazyStream<AppEditTextStyle> _style =
      LazyStream(() => ExampleTheme.getTheme().edittext.defaults);

  final LazyStream<int> _currentLength = LazyStream(() => 0);
  final LazyStream<bool> _success = LazyStream<bool>(() => false);
  final LazyStream<bool> _error = LazyStream<bool>(() => false);

  Widget getLeftWidget(AppEditTextStyle style) {
    if (leftWidget != null) {
      return leftWidget;
    }

    final onTap = enabled ? onLeftTap : null;

    if (leftIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
        child: MyIcon.icon(leftIcon, color: style.iconColor, size: 20, onTap: onTap),
      );
    }
    return null;
  }

  Widget getInputField(AppEditTextStyle style) {
    var padding = const EdgeInsets.only(top: 4, bottom: 4);
    if (Util.isEmpty(labelText)) {
      padding = const EdgeInsets.only(top: 10, bottom: 10);
    }

    final hasLines = (minLines ?? maxLines ?? lines ?? 0) > 1;

    final decorator = getDecorator(style);
    final cKeyboardType = keyboardType ?? (hasLines ? TextInputType.multiline : TextInputType.text);
    final cTextInputAction =
        textInputAction ?? (hasLines ? TextInputAction.newline : TextInputAction.done);
    final cTextStyle =
        textStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.textColor);
    //
    return Expanded(
      child: Padding(
        padding: padding,
        child: TextFormField(
          focusNode: focusNode,
          enabled: enabled,
          minLines: lines ?? minLines,
          maxLines: lines ?? maxLines,
          decoration: decorator,
          controller: textController,
          keyboardType: cKeyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          textInputAction: cTextInputAction,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          style: cTextStyle,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          validator: validator,
          autofocus: autofocus,
          autofillHints: autoFillHints,
          inputFormatters: inputFormatters,
        ),
      ),
    );
  }

  Widget getRightWidget(AppEditTextStyle style) {
    if (rightWidget != null) {
      return rightWidget;
    }

    final onTap = enabled ? onRightTap : null;

    if (rightIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
        child: MyIcon.icon(rightIcon, color: style.iconColor, size: 20, onTap: onTap),
      );
    } else if (rightIconButton != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 4),
        child: GLButton.regular(
          width: 35,
          height: 35,
          icon: rightIconButton,
          style: style.buttonStyle,
          onTap: this.enabled
              ? () {
                  focusNode?.unfocus();
                  onTap?.call();
                }
              : null,
        ),
      );
    }
    return null;
  }

  Widget getStatusText() {
    if (errorWidget != null) {
      return errorWidget;
    } else if (Util.nonEmpty(errorText)) {
      return MyText(
        errorText,
        style: errorStyle ??
            ExampleTheme.getTheme().textStyle.caption(color: ExampleColor.getColor().status.error),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    } else if (successWidget != null) {
      return successWidget;
    } else if (Util.nonEmpty(successText)) {
      return MyText(
        successText,
        style: successStyle ??
            ExampleTheme.getTheme()
                .textStyle
                .caption(color: ExampleColor.getColor().status.success),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    }
    return null;
  }

  Widget getHelperText() {
    if (helperWidget != null) {
      return helperWidget;
    }

    if (Util.nonEmpty(helperText)) {
      return MyText(
        helperText,
        style: helperStyle ??
            ExampleTheme.getTheme()
                .textStyle
                .caption(color: ExampleColor.getColor().text.medium_emphasis),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    }
    return null;
  }

  void reloadStyle() {
    if (style != null) {
      _style.add(style);
      return;
    }

    if (!(enabled ?? true)) {
      _style.add(ExampleTheme.getTheme().edittext.disabled);
    } else if (focusNode?.hasFocus == true) {
      _style.add(ExampleTheme.getTheme().edittext.focus);
    } else if (_error.value ?? false) {
      _style.add(ExampleTheme.getTheme().edittext.error);
    } else if (_success.value ?? false) {
      _style.add(ExampleTheme.getTheme().edittext.success);
    } else if (textController.text?.isNotEmpty == true) {
      _style.add(ExampleTheme.getTheme().edittext.filled);
    } else {
      _style.add(ExampleTheme.getTheme().edittext.defaults);
    }
  }

  @override
  void onDestroy() {
    _success.close();
    _error.close();
    _style.close();
    _currentLength.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppEditTextStyle>(
        stream: _style.stream,
        builder: (_, st) {
          final style = st.data ?? ExampleTheme.getTheme().edittext.defaults;
          return MyTable.vertical(
            [
              VWidget(
                width: double.infinity,
                height: 56,
                child: MyTable.horizontal(
                  [
                    getLeftWidget(style),
                    getInputField(style),
                    getRightWidget(style),
                  ]..removeWhere((e) => e == null),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                background: style.background,
                borderRadius: borderRadius ?? ExampleTheme.getTheme().edittext_radius,
                borderColor: style.borderColor,
                margin: margin ?? const EdgeInsets.all(4),
              ),
              MyTable.horizontal([
                MyTable.vertical(
                  [
                    getStatusText(),
                    getHelperText(),
                  ]..removeWhere((e) => e == null),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  flex: 1,
                ),
                if (maxLength != null && maxLength > 0)
                  StreamBuilder<int>(
                      stream: _currentLength.stream,
                      builder: (_, st) {
                        final currentLength = st.data ?? 0;
                        var textColor = ExampleColor.getColor().text.medium_emphasis;
                        if (currentLength > maxLength) {
                          textColor = ExampleColor.getColor().status.error;
                        }
                        return MyText(
                          "$currentLength/$maxLength",
                          style: ExampleTheme.getTheme().textStyle.caption(color: textColor),
                          padding: const EdgeInsets.only(right: 16),
                        );
                      }),
              ]),
            ]..removeWhere((e) => e == null),
            crossAxisAlignment: CrossAxisAlignment.end,
          );
        });
  }

  InputDecoration getDecorator(AppEditTextStyle style) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      labelText: Util.isEmpty(labelText) ? null : labelText,
      labelStyle:
          labelStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.labelTextColor),
      hintText: hintText,
      hintStyle:
          hintStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.hintTextColor),
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      counterText: counterText,
      contentPadding: const EdgeInsets.only(left: 8, right: 8),
    );
  }
}

class GLEditText extends VContainer {
  final String text;
  final TextStyle textStyle;
  final AppEditTextStyle style;
  final bool enabled;
  final bool readOnly;
  final bool onlyEnabled;
  final bool showCursor;
  final bool autofocus;
  final bool backgroundHover;
  final Iterable<String> autoFillHints;
  final int lines;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;

  //
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;
  final String helperText;
  final TextStyle helperStyle;
  final Widget helperWidget;

  //
  final String errorText;
  final TextStyle errorStyle;
  final Widget errorWidget;
  final String successText;
  final TextStyle successStyle;
  final Widget successWidget;

  //
  final String prefixText;
  final TextStyle prefixStyle;
  final String suffixText;
  final TextStyle suffixStyle;
  final String counterText;

  //
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final bool obscureText;

  //
  final IconData leftIcon;
  final Widget leftWidget;
  final GestureTapCallback onLeftTap;

  //
  final IconData rightIcon;
  final IconData rightIconButton;
  final Widget rightWidget;
  final GestureTapCallback onRightTap;

  //
  final BorderRadiusGeometry borderRadius;
  final Color borderColor;
  final double inputFieldHeight;
  final EdgeInsetsGeometry margin;
  final ValueChanged<String> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final TextAlign textAlign;

  GLEditText({
    this.text,
    this.textStyle,
    this.enabled = true,
    this.readOnly,
    this.showCursor,
    this.onlyEnabled,
    this.autofocus = false,
    this.backgroundHover = false,
    this.autoFillHints,
    FocusNode focusNode,
    this.lines,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    TextEditingController textController,
    this.style,
    //
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    //
    this.helperText,
    this.helperStyle,
    this.helperWidget,
    //
    bool error = false,
    Stream<bool> errorStream,
    this.errorText,
    this.errorStyle,
    this.errorWidget,
    bool success = false,
    Stream<bool> successStream,
    TextAlign textAlign,
    this.successText,
    this.successStyle,
    this.successWidget,
    //
    this.prefixText,
    this.prefixStyle,
    this.suffixText,
    this.suffixStyle,
    //
    this.counterText,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.obscureText,
    //
    this.leftIcon,
    this.leftWidget,
    this.onLeftTap,
    this.rightIcon,
    this.rightIconButton,
    this.rightWidget,
    //
    this.onRightTap,
    this.borderRadius,
    this.borderColor,
    this.margin,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.inputFieldHeight,
  })  : textController = textController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode(),
        textAlign = textAlign ?? TextAlign.start {
    if (text != null && text.isNotEmpty) {
      this.textController.text = text;
    }

    if (maxLength != null && maxLength > 0) {
      this.textController.addListener(() {
        _currentLength.add(this.textController.text.length);
      });
    }

    _style.add(style);

    _success.add(success == true || Util.nonEmpty(successText) || successWidget != null);
    _error.add(error == true || Util.nonEmpty(errorText) || errorWidget != null);

    successStream?.listen((event) {
      _success.add(event ?? false);
    });

    errorStream?.listen((event) {
      _error.add(event ?? false);
    });

    this.focusNode.addListener(() => reloadStyle());

    _success.stream.listen((event) => reloadStyle());
    _error.stream.listen((event) => reloadStyle());

    reloadStyle();
  }

  final FocusNode focusNode;
  final LazyStream<AppEditTextStyle> _style =
      LazyStream(() => ExampleTheme.getTheme().edittext.regular);

  final LazyStream<int> _currentLength = LazyStream(() => 0);
  final LazyStream<bool> _success = LazyStream<bool>(() => false);
  final LazyStream<bool> _error = LazyStream<bool>(() => false);

  Widget getLeftWidget(AppEditTextStyle style) {
    if (leftWidget != null) {
      return leftWidget;
    }

    final onTap = enabled ? onLeftTap : null;

    if (leftIcon != null) {
      return Container(
        margin: const EdgeInsets.only(left: 14, right: 12, top: 16, bottom: 16),
        child: MyIcon.icon(leftIcon, color: style.iconColor, size: 20, onTap: onTap),
      );
    }
    return null;
  }

  Widget getInputField(AppEditTextStyle style) {
    double top = 4;
    double bottom = 4;
    double left = 16;
    if (Util.isEmpty(labelText)) {
      top = 10;
      bottom = 10;
    }
    if (leftIcon != null || leftWidget != null) {
      left = 8;
    }
    var padding = EdgeInsets.only(top: top, bottom: bottom, left: left);
    final hasLines = (minLines ?? maxLines ?? lines ?? 0) > 1;

    final decorator = getDecorator(style);
    final cKeyboardType = keyboardType ?? (hasLines ? TextInputType.multiline : TextInputType.text);
    final cTextInputAction =
        textInputAction ?? (hasLines ? TextInputAction.newline : TextInputAction.done);
    final cTextStyle =
        textStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: style.textColor);
    //
    return Expanded(
      child: Padding(
        padding: padding,
        child: TextFormField(
          focusNode: focusNode,
          showCursor: showCursor ?? true,
          readOnly: readOnly == true,
          enabled: onlyEnabled ?? enabled,
          minLines: lines ?? minLines,
          maxLines: lines ?? maxLines,
          decoration: decorator,
          controller: textController,
          keyboardType: cKeyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          textInputAction: cTextInputAction,
          textAlign: textAlign,
          textAlignVertical: TextAlignVertical.top,
          style: cTextStyle,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          validator: validator,
          autofocus: autofocus,
          autofillHints: autoFillHints,
          inputFormatters: (inputFormatters ?? [])..add(Emojis.emojiFilter),
        ),
      ),
    );
  }

  Widget getRightWidget(AppEditTextStyle style) {
    if (rightWidget != null) {
      return rightWidget;
    }

    final onTap = enabled ? onRightTap : null;

    if (rightIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
        child: MyIcon.icon(rightIcon, color: style.iconColor, size: 20, onTap: onTap),
      );
    } else if (rightIconButton != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 4),
        child: GLButton.regular(
          width: 35,
          height: 35,
          icon: rightIconButton,
          style: style.buttonStyle,
          onTap: this.enabled
              ? () {
                  focusNode.unfocus();
                  onTap?.call();
                }
              : null,
        ),
      );
    }
    return null;
  }

  Widget getStatusText() {
    if (errorWidget != null) {
      return errorWidget;
    } else if (Util.nonEmpty(errorText)) {
      return MyText(
        errorText,
        style: errorStyle ??
            ExampleTheme.getTheme().textStyle.caption(color: ExampleColor.getColor().status.error),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    } else if (successWidget != null) {
      return successWidget;
    } else if (Util.nonEmpty(successText)) {
      return MyText(
        successText,
        style: successStyle ??
            ExampleTheme.getTheme()
                .textStyle
                .caption(color: ExampleColor.getColor().status.success),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    }
    return null;
  }

  Widget getHelperText() {
    if (helperWidget != null) {
      return helperWidget;
    }

    if (Util.nonEmpty(helperText)) {
      return MyText(
        helperText,
        style: helperStyle ??
            ExampleTheme.getTheme()
                .textStyle
                .caption(color: ExampleColor.getColor().text.regular_medium),
        padding: const EdgeInsets.only(left: 16, right: 16),
      );
    }
    return null;
  }

  void reloadStyle() {
    if (style != null) {
      _style.add(style);
      return;
    }

    if (!(enabled ?? true)) {
      _style.add(ExampleTheme.getTheme().edittext.disabled);
    } else if (focusNode.hasFocus) {
      _style.add(ExampleTheme.getTheme().edittext.focus);
    } else if (_error.value ?? false) {
      _style.add(ExampleTheme.getTheme().edittext.error);
    } else if (_success.value ?? false) {
      _style.add(ExampleTheme.getTheme().edittext.success);
    } else if (textController.text?.isNotEmpty == true) {
      _style.add(ExampleTheme.getTheme().edittext.filled);
    } else {
      _style.add(ExampleTheme.getTheme().edittext.regular);
    }
  }

  @override
  void onDestroy() {
    _success.close();
    _error.close();
    _style.close();
    _currentLength.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppEditTextStyle>(
        stream: _style.stream,
        builder: (_, st) {
          final style = st.data ?? ExampleTheme.getTheme().edittext.regular;
          return MyTable.vertical(
            [
              VWidget(
                width: double.infinity,
                height: inputFieldHeight ?? 56,
                child: MyTable.horizontal(
                  [
                    getLeftWidget(style),
                    getDivider(),
                    getInputField(style),
                    getRightWidget(style),
                  ]..removeWhere((e) => e == null),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                background: backgroundHover ? style.backgroundHover : style.background,
                borderRadius: borderRadius ?? ExampleTheme.getTheme().edittext_radius,
                borderColor: borderColor ?? style.borderColor,
                margin: margin ?? const EdgeInsets.all(4),
              ),
              MyTable.horizontal([
                MyTable.vertical(
                  [
                    getStatusText(),
                    getHelperText(),
                  ]..removeWhere((e) => e == null),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  flex: 1,
                ),
                if (maxLength != null && maxLength > 0)
                  StreamBuilder<int>(
                      stream: _currentLength.stream,
                      builder: (_, st) {
                        final currentLength = st.data ?? 0;
                        var textColor = ExampleColor.getColor().text.medium_emphasis;
                        if (currentLength > maxLength) {
                          textColor = ExampleColor.getColor().status.error;
                        }
                        return MyText(
                          "$currentLength/$maxLength",
                          style: ExampleTheme.getTheme().textStyle.caption(color: textColor),
                          padding: const EdgeInsets.only(right: 16),
                        );
                      }),
              ]),
            ]..removeWhere((e) => e == null),
            crossAxisAlignment: CrossAxisAlignment.end,
          );
        });
  }

  InputDecoration getDecorator(AppEditTextStyle style) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      labelText: Util.isEmpty(labelText) ? null : labelText,
      labelStyle:
          labelStyle ?? ExampleTheme.getTheme().textStyle.body1(color: style.labelTextColor),
      hintText: hintText,
      hintStyle: hintStyle ?? ExampleTheme.getTheme().textStyle.body1(color: style.hintTextColor),
      prefixText: prefixText,
      prefixStyle: prefixStyle,
      suffixText: suffixText,
      suffixStyle: suffixStyle,
      counterText: counterText,
      contentPadding: const EdgeInsets.only(left: 8, right: 8),
    );
  }

  Widget getDivider() {
    if (leftIcon != null) {
      return Container(
        child: VerticalDivider(
          color: ExampleColor.getColor().systemStyle.systemNavigationBarDividerColor,
          width: 1,
        ),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
      );
    }
    return null;
  }
}
