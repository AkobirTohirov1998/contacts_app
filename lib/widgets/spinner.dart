import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/container.dart';
import 'package:first_app/widgets/edit_text.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

typedef OnSpinnerItemSelect = void Function(VSpinnerOption option);

// ignore: must_be_immutable
class VSpinner extends VContainer {
  final List<VSpinnerOption> options;
  final String optionCode;
  final double width;
  final double height;
  final TextStyle textStyle;
  final bool enabled;
  final bool isLight;
  final String notSelectedText;

  //
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;

  //
  final bool error;
  final Stream<bool> errorStream;
  final bool success;
  final Stream<bool> successStream;

  //
  final IconData leftIcon;
  final Widget leftWidget;

  VSpinner({
    @required this.options,
    this.optionCode,
    this.width,
    this.height,
    this.textStyle,
    this.enabled = true,
    this.isLight = true,
    this.notSelectedText,
    //
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    //
    this.error,
    this.errorStream,
    this.success,
    this.successStream,
    //
    this.leftIcon,
    this.leftWidget,
    //
  }) {
    if (options == null || options.isEmpty) {
      throw Exception("spinner options is empty");
    }
    if (options.containsWhere((e) => Util.isEmpty(e.code))) {
      throw Exception("One of the options is code is null or empty");
    }

    if (optionCode != null) {
      final foundOption = this.options.findWhere((e) => e.code == optionCode);
      if (foundOption != null) {
        _option.add(foundOption);
      } else {
        throw Exception("Option=$optionCode not fount");
      }
    }

    _option.stream.skip(1).listen((option) {
      if (option != null) {
        for (var onListener in _listeners) {
          onListener.call(option);
        }
      }
    });
  }

  final LazyStream<VSpinnerOption> _option = LazyStream();

  final List<OnSpinnerItemSelect> _listeners = [];

  void addOnChangeListener(OnSpinnerItemSelect onChangeListener) {
    _listeners.add(onChangeListener);
  }

  VSpinnerOption getSelectedOption() {
    return _option.value;
  }

  @override
  void onDestroy() {
    _option.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.buildDropdown(),
      width: width,
      height: height,
    );
  }

  Widget buildSelected(AppEditTextStyle style, VSpinnerOption option) {
    return VEditText(
      text: option.text,
      style: style,
      lines: 1,
      textStyle: textStyle,
      labelText: labelText,
      labelStyle: labelStyle,
      hintText: hintText,
      hintStyle: hintStyle,
      error: error,
      errorStream: errorStream,
      success: success,
      successStream: successStream,
      enabled: false,
      leftIcon: leftIcon,
      leftWidget: leftWidget,
      rightIcon: Icons.arrow_drop_down,
      margin: EdgeInsets.zero,
    );
  }

  Widget buildDropdown() {
    final spinnerOptions = [
      if (Util.nonEmpty(notSelectedText)) VSpinnerOption("", notSelectedText, null),
      ...options
    ];
    return StreamBuilder<VSpinnerOption>(
        stream: _option.stream,
        initialData: _option.value,
        builder: (_, st) {
          VSpinnerOption selected = st.data;

          AppEditTextStyle style = ExampleTheme.getTheme().edittext.defaults;
          if (!enabled) {
            if (isLight) {
              style = ExampleTheme.getTheme().edittext.disabled;
            } else {
              style = ExampleTheme.getTheme().edittext.darkDisabled;
            }
          } else if (selected != null && Util.nonEmpty(selected.code)) {
            if (isLight) {
              style = ExampleTheme.getTheme().edittext.filled;
            } else {
              style = ExampleTheme.getTheme().edittext.dark;
            }
          }
          return DropdownButton(
            style: TextStyle(color: ExampleColor.getColor().text.high_emphasis),
            underline: Container(),
            isExpanded: true,
            icon: Container(),
            iconSize: 20,
            // elevation: 5,
            itemHeight: 56,
            value: selected?.code ?? "",
            selectedItemBuilder: (_) {
              return spinnerOptions.map((e) => this.buildSelected(style, e)).toList();
            },
            items: spinnerOptions.map((e) {
              return DropdownMenuItem<String>(
                // onTap: () => this._option.add(e),
                value: e.code,
                child: MyText(Util.isEmpty(e.text) ? this.notSelectedText : e.text),
              );
            }).toList(),
            disabledHint: this.buildSelected(style, selected ?? spinnerOptions.first),
            onChanged: this.enabled
                ? (optionCode) {
                    final option = spinnerOptions.findWhere((e) => e.code == optionCode);
                    this._option.add(option);
                  }
                : null,
          );
        });
  }
}

class VSpinnerOption {
  final String code;
  final String text;
  final dynamic tag;

  VSpinnerOption(this.code, this.text, this.tag);
}

typedef OnGLSpinnerItemSelect = void Function(GLSpinnerOption option);

class GLSpinnerOption {
  final String code;
  final String text;
  final dynamic tag;

  GLSpinnerOption(this.code, this.text, this.tag);
}

class GLSpinner extends VContainer {
  final List<GLSpinnerOption> options;
  final String optionCode;
  final double width;
  final double height;
  final TextStyle textStyle;
  final bool enabled;
  final bool isLight;
  final String notSelectedText;

  //
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;

  //
  final bool error;
  final Stream<bool> errorStream;
  final bool success;
  final Stream<bool> successStream;

  //
  final IconData leftIcon;
  final Widget leftWidget;

  GLSpinner({
    @required this.options,
    this.optionCode,
    this.width,
    this.height,
    this.textStyle,
    this.enabled = true,
    this.isLight = true,
    this.notSelectedText,
    //
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    //
    this.error,
    this.errorStream,
    this.success,
    this.successStream,
    //
    this.leftIcon,
    this.leftWidget,
    //
  }) {
    if (options == null || options.isEmpty) {
      throw Exception("spinner options is empty");
    }
    if (options.containsWhere((e) => Util.isEmpty(e.code))) {
      throw Exception("One of the options is code is null or empty");
    }

    if (optionCode != null) {
      final foundOption = this.options.findWhere((e) => e.code == optionCode);
      if (foundOption != null) {
        _option.add(foundOption);
      } else {
        throw Exception("Option=$optionCode not fount");
      }
    }

    this._option.stream.listen((option) {
      if (option != null) {
        _listeners.forEach((onListener) {
          onListener.call(option);
        });
      }
    });
  }

  final LazyStream<GLSpinnerOption> _option = new LazyStream();

  final List<OnGLSpinnerItemSelect> _listeners = [];

  void addOnChangeListener(OnGLSpinnerItemSelect onChangeListener) {
    _listeners.add(onChangeListener);
  }

  GLSpinnerOption getSelectedOption() {
    return _option.value;
  }

  @override
  void onDestroy() {
    _option.close();
    super.onDestroy();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: buildDropdown(),
      width: width,
      height: height,
    );
  }

  Widget buildSelected(AppEditTextStyle style, GLSpinnerOption option) {
    return GLEditText(
      text: option.text,
      style: style,
      lines: 1,
      textStyle: textStyle,
      labelText: labelText,
      labelStyle: labelStyle,
      hintText: hintText,
      hintStyle: hintStyle,
      error: error,
      errorStream: errorStream,
      success: success,
      successStream: successStream,
      enabled: false,
      leftIcon: leftIcon,
      leftWidget: leftWidget,
      rightIcon: Icons.arrow_drop_down,
      margin: EdgeInsets.zero,
    );
  }

  Widget buildDropdown() {
    final spinnerOptions = [
      if (Util.nonEmpty(notSelectedText)) GLSpinnerOption("", null, null),
      ...options,
    ];
    return StreamBuilder<GLSpinnerOption>(
        stream: _option.stream,
        initialData: _option.value,
        builder: (_, st) {
          GLSpinnerOption selected = st.data;

          AppEditTextStyle style = ExampleTheme.getTheme().edittext.defaults;
          if (!enabled) {
            if (isLight) {
              style = ExampleTheme.getTheme().edittext.disabled;
            } else {
              style = ExampleTheme.getTheme().edittext.darkDisabled;
            }
          } else if (selected != null && Util.nonEmpty(selected.code)) {
            if (isLight) {
              style = ExampleTheme.getTheme().edittext.filled;
            } else {
              style = ExampleTheme.getTheme().edittext.dark;
            }
          }
          return DropdownButton(
            style: TextStyle(color: ExampleColor.getColor().text.high_emphasis),
            underline: Container(),
            isExpanded: true,
            icon: Container(),
            iconSize: 20,
            itemHeight: 56,
            value: selected?.code ?? "",
            selectedItemBuilder: (_) {
              return spinnerOptions.map((e) => buildSelected(style, e)).toList();
            },
            items: spinnerOptions.map((e) {
              return DropdownMenuItem<String>(
                value: e.code,
                child: MyText(Util.isEmpty(e.text) ? notSelectedText : e.text),
              );
            }).toList(),
            disabledHint: buildSelected(style, selected ?? spinnerOptions.first),
            hint: Container(width: 100, height: 100, color: ExampleColor.getColor().contrast),
            onChanged: enabled
                ? (optionCode) {
                    final option = spinnerOptions.findWhere((e) => e.code == optionCode);
                    _option.add(option);
                  }
                : null,
          );
        });
  }
}
