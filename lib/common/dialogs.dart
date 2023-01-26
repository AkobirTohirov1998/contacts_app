import 'dart:io';

import 'package:first_app/main.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/card.dart';
import 'package:first_app/widgets/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/gwslib.dart';

class Dialogs {
  static ProgressDialogBuilder get progressDialog => ProgressDialogBuilder();

  static ConfirmationDialogBuilder confirmation() => ConfirmationDialogBuilder();

  static NewAlertBottomSheetDialogBuilder newAlertBottomSheet() =>
      NewAlertBottomSheetDialogBuilder();

  static _ConfirmationBottomSheetBuilder<T> confirmationBottomSheet<T>() =>
      _ConfirmationBottomSheetBuilder<T>();

  static _NewConfirmationBottomSheetBuilder<T> newConfirmationBottomSheet<T>() =>
      _NewConfirmationBottomSheetBuilder<T>();

  static _AlertListBottomSheetBuilder alertListBottomSheet() => _AlertListBottomSheetBuilder();

  static _AlertBottomSheetDialogBuilder alertBottomSheet() => _AlertBottomSheetDialogBuilder();

  static AlertDialogDialogBuilder alert() => AlertDialogDialogBuilder();

  static ErrorAlertDialogDialogBuilder errorAlert() => ErrorAlertDialogDialogBuilder();
}

class _AlertBottomSheetDialogBuilder {
  String _title;
  String _message;
  bool _dismissible;

  String positiveBtnText;
  String negativeBtnText;
  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;

  _AlertBottomSheetDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  _AlertBottomSheetDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  _AlertBottomSheetDialogBuilder dismissible(bool dismissible) {
    this._dismissible = dismissible;
    return this;
  }

  _AlertBottomSheetDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  _AlertBottomSheetDialogBuilder negative(String negativeBtnText, VoidCallback function) {
    this.negativeBtnClickAction = function;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  Future<T> show<T>(BuildContext myContext) async {
    final safeArea = MediaQuery.of(myContext).padding.bottom;
    return showModalBottomSheet(
        context: myContext,
        isDismissible: _dismissible ?? true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        builder: (context) {
          return ClipRRect(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16 + safeArea),
              child: MyTable.vertical([
                MyText(
                  _title,
                  style: ExampleTheme.getTheme()
                      .textStyle
                      .title_5(color: ExampleColor.getColor().text.high_emphasis),
                ),
                if (_message?.isNotEmpty == true)
                  MyText(_message,
                      padding: EdgeInsets.only(top: 4),
                      style: ExampleTheme.getTheme()
                          .textStyle
                          .paragraph(color: ExampleColor.getColor().text.high_emphasis)),
                SizedBox(height: 22),
                Divider(height: 1, color: Colors.grey),
                SizedBox(height: 12),
                MyTable.horizontal(
                  [
                    if (negativeBtnText?.isNotEmpty == true)
                      VButton.normal(
                        flex: 1,
                        text: negativeBtnText,
                        style: ExampleTheme.getTheme().button_normal.primary3,
                        onTap: () {
                          Navigator.of(context).pop(false);
                          negativeBtnClickAction?.call();
                        },
                      ),
                    SizedBox(width: 8),
                    if (positiveBtnText?.isNotEmpty == true)
                      VButton.normal(
                        flex: 1,
                        text: positiveBtnText,
                        style: ExampleTheme.getTheme().button_normal.error,
                        onTap: () {
                          Navigator.of(context).pop(true);
                          positiveBtnClickAction?.call();
                        },
                      ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                )
              ]),
            ),
          );
        });
  }
}

class ConfirmationDialogBuilder {
  String _title;

  // String _message;
  String positiveBtnText;
  String negativeBtnText;
  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;
  List<ConfirmationOption> _options = [];

  ConfirmationDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  // ConfirmationDialogBuilder message(String _message) {
  //   this._message = _message;
  //   return this;
  // }

  ConfirmationDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  ConfirmationDialogBuilder options<T>(
      List<T> values,
      DialogsTitleFunction<T> titleFunction,
      DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
      DialogsItemSelectAction<T> itemSelectAction) {
    for (var value in values) {
      _options.add(ConfirmationOption(
        title: titleFunction.call(value),
        subTitle: subTitleTitleFunction.call(value),
        clickAction: () => itemSelectAction.call(value),
      ));
    }
    return this;
  }

  ConfirmationDialogBuilder option(String title, String subTitle, VoidCallback callBack) {
    _options.add(ConfirmationOption(title: title, subTitle: subTitle, clickAction: callBack));
    return this;
  }

  void show(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.bottom;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
          contentPadding: EdgeInsets.only(top: 10.0, bottom: safeArea),
          title: MyText(_title),
          children: widgets(context),
        );
      },
    );
  }

  List<Widget> widgets(BuildContext context) {
    return _options.map((e) {
      if (e.subTitle?.isNotEmpty == true) {
        return SimpleDialogOption(
          child: ListTile(
            title: MyText(e.title, style: ExampleTheme.getTheme().textStyle.paragraph()),
            subtitle: MyText(e.subTitle,
                style: ExampleTheme.getTheme().textStyle.caption(color: Colors.black54)),
          ),
          onPressed: () {
            Mold.onContextBackPressed(context);
            e.clickAction.call();
          },
        );
      } else {
        return SimpleDialogOption(
          child: ListTile(
              title: MyText(e.title, style: ExampleTheme.getTheme().textStyle.paragraph())),
          onPressed: () {
            Mold.onContextBackPressed(context);
            e.clickAction.call();
          },
        );
      }
    }).toList();
  }
}

class _ConfirmationBottomSheetBuilder<T> {
  String _title;
  bool _dismissible;

  // String _message;
  String positiveBtnText;
  String negativeBtnText;
  DialogsItemSelectAction<T> positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;
  List<_BottomSheetConfirmationOption<T>> _options = [];
  _BottomSheetConfirmationOption<T> _selectedOption;
  String _selectedOptionCode;

  _ConfirmationBottomSheetBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  _ConfirmationBottomSheetBuilder negative(
      String negativeBtnText, VoidCallback negativeBtnClickAction) {
    this.negativeBtnClickAction = negativeBtnClickAction;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  _ConfirmationBottomSheetBuilder positive(
      String positiveBtnText, DialogsItemSelectAction<T> function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  _ConfirmationBottomSheetBuilder dismissible(bool dismissible) {
    this._dismissible = dismissible;
    return this;
  }

  _ConfirmationBottomSheetBuilder options(
    List<T> values,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
  }) {
    for (var value in values) {
      _options.add(_BottomSheetConfirmationOption<T>(
        codeFunction.call(value),
        titleFunction.call(value),
        subTitleTitleFunction?.call(value),
        tag: value,
      ));
    }
    return this;
  }

  _ConfirmationBottomSheetBuilder option(
    T value,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
  }) {
    _options.add(_BottomSheetConfirmationOption<T>(
      codeFunction.call(value),
      titleFunction.call(value),
      subTitleTitleFunction?.call(value),
      tag: value,
    ));
    return this;
  }

  _ConfirmationBottomSheetBuilder selectedOption(
    T value,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
  }) {
    _selectedOption = _BottomSheetConfirmationOption<T>(
      codeFunction.call(value),
      titleFunction.call(value),
      subTitleTitleFunction?.call(value),
      tag: value,
    );
    return this;
  }

  _ConfirmationBottomSheetBuilder selectedOptionCode(String code) {
    _selectedOptionCode = code;
    return this;
  }

  void show(BuildContext myContext) {
    _BottomSheetConfirmationOption<T> selectedOption = getSelectedOption();
    showModalBottomSheet(
        context: myContext,
        isDismissible: _dismissible ?? true,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        builder: (context) {
          return _ConfirmationBottomSheetWidget<T>(
            context,
            _title,
            _options,
            selectedOption,
            positiveBtnText,
            negativeBtnText,
            positiveBtnClickAction,
            negativeBtnClickAction,
          );
        });
  }

  _BottomSheetConfirmationOption<T> getSelectedOption() {
    if (_selectedOptionCode != null) {
      final option = _options.firstWhereOrNull((element) => element.code == _selectedOptionCode);

      if (option == null) {
        throw Exception("Selected option(code:$_selectedOptionCode) not found from options list");
      }

      return option;
    }

    if (_selectedOption != null) {
      final option = _options.firstWhereOrNull((element) => element.code == _selectedOption.code);

      if (option == null) {
        throw Exception(
            "Selected option(code:${_selectedOption.code}) not found from options list");
      }

      return option;
    }
    return null;
  }
}

class _NewConfirmationBottomSheetBuilder<T> {
  String _title;
  Widget _titleWidget;
  TextStyle _titleStyle;
  IconData _icon;
  Color _iconColor;
  bool _dismissible;
  bool _hasDivider;

  String positiveBtnText;
  AppButtonStyle positiveBtnStyle;
  DialogsItemSelectAction<T> positiveBtnClickAction;

  String negativeBtnText;
  AppButtonStyle negativeBtnStyle;
  VoidCallback negativeBtnClickAction;

  List<_BottomSheetConfirmationOption<T>> _options = [];
  _BottomSheetConfirmationOption<T> _selectedOption;
  String _selectedOptionCode;

  _NewConfirmationBottomSheetBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  _NewConfirmationBottomSheetBuilder titleWidget(Widget titleWidget) {
    this._titleWidget = titleWidget;
    return this;
  }

  _NewConfirmationBottomSheetBuilder icon(IconData icon) {
    this._icon = icon;
    return this;
  }

  _NewConfirmationBottomSheetBuilder iconColor(Color iconColor) {
    this._iconColor = iconColor;
    return this;
  }

  _NewConfirmationBottomSheetBuilder titleStyle(TextStyle titleStyle) {
    this._titleStyle = titleStyle;
    return this;
  }

  _NewConfirmationBottomSheetBuilder negative(
      String negativeBtnText, VoidCallback negativeBtnClickAction,
      {AppButtonStyle negativeBtnStyle}) {
    this.negativeBtnClickAction = negativeBtnClickAction;
    this.negativeBtnText = negativeBtnText;
    this.negativeBtnStyle = negativeBtnStyle;
    return this;
  }

  _NewConfirmationBottomSheetBuilder positive(
      String positiveBtnText, DialogsItemSelectAction<T> function,
      {AppButtonStyle positiveBtnStyle}) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    this.positiveBtnStyle = positiveBtnStyle;
    return this;
  }

  _NewConfirmationBottomSheetBuilder dismissible(bool dismissible) {
    this._dismissible = dismissible;
    return this;
  }

  _NewConfirmationBottomSheetBuilder hasDivider(bool hasDivider) {
    this._hasDivider = hasDivider;
    return this;
  }

  _NewConfirmationBottomSheetBuilder options(
    List<T> values,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
    TextStyle titleStyle,
    TextStyle subTitleStyle,
  }) {
    for (var value in values) {
      _options.add(_BottomSheetConfirmationOption<T>(
        codeFunction.call(value),
        titleFunction.call(value),
        subTitleTitleFunction?.call(value),
        tag: value,
        titleStyle: titleStyle,
        subTitleStyle: subTitleStyle,
      ));
    }
    return this;
  }

  _NewConfirmationBottomSheetBuilder option(
    T value,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
    TextStyle titleStyle,
    TextStyle subTitleStyle,
  }) {
    _options.add(_BottomSheetConfirmationOption<T>(
      codeFunction.call(value),
      titleFunction.call(value),
      subTitleTitleFunction?.call(value),
      tag: value,
      titleStyle: titleStyle,
      subTitleStyle: subTitleStyle,
    ));
    return this;
  }

  _NewConfirmationBottomSheetBuilder selectedOption(
    T value,
    DialogsTitleFunction<T> codeFunction,
    DialogsTitleFunction<T> titleFunction, {
    DialogsSubTitleTitleFunction<T> subTitleTitleFunction,
    TextStyle titleStyle,
    TextStyle subTitleStyle,
  }) {
    _selectedOption = _BottomSheetConfirmationOption<T>(
      codeFunction.call(value),
      titleFunction.call(value),
      subTitleTitleFunction?.call(value),
      tag: value,
      titleStyle: titleStyle,
      subTitleStyle: subTitleStyle,
    );
    return this;
  }

  _NewConfirmationBottomSheetBuilder selectedOptionCode(String code) {
    _selectedOptionCode = code;
    return this;
  }

  void show(BuildContext myContext) {
    _BottomSheetConfirmationOption<T> selectedOption = getSelectedOption();
    showModalBottomSheet(
        context: myContext,
        isDismissible: _dismissible ?? true,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )),
        builder: (context) {
          return _NewConfirmationBottomSheetWidget<T>(
            context,
            _title,
            _titleWidget,
            _titleStyle,
            _icon,
            _iconColor,
            _hasDivider,
            _options,
            selectedOption,
            positiveBtnText,
            positiveBtnStyle,
            negativeBtnText,
            negativeBtnStyle,
            positiveBtnClickAction,
            negativeBtnClickAction,
          );
        });
  }

  _BottomSheetConfirmationOption<T> getSelectedOption() {
    if (_selectedOptionCode != null) {
      final option = _options.firstWhereOrNull((element) => element.code == _selectedOptionCode);

      if (option == null) {
        throw Exception("Selected option(code:$_selectedOptionCode) not found from options list");
      }

      return option;
    }

    if (_selectedOption != null) {
      final option = _options.firstWhereOrNull((element) => element.code == _selectedOption.code);

      if (option == null) {
        throw Exception(
            "Selected option(code:${_selectedOption.code}) not found from options list");
      }

      return option;
    }
    return null;
  }
}

class _AlertListBottomSheetBuilder {
  String _title;
  Widget _titleWidget;
  String _subtitle;
  TextStyle _titleStyle;
  TextStyle _subtitleStyle;
  IconData _icon;
  Color _iconColor;
  bool _dismissible;

  String positiveBtnText;
  String negativeBtnText;

  AppButtonStyle _positiveBtnStyle;
  AppButtonStyle _negativeBtnStyle;

  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;

  bool _hasDivider;
  List<BottomSheetListItem> _items = [];

  _AlertListBottomSheetBuilder title(String title) {
    this._title = title;
    return this;
  }

  _AlertListBottomSheetBuilder titleWidget(Widget titleWidget) {
    this._titleWidget = titleWidget;
    return this;
  }

  _AlertListBottomSheetBuilder subtitle(String subtitle) {
    this._subtitle = subtitle;
    return this;
  }

  _AlertListBottomSheetBuilder icon(IconData icon) {
    this._icon = icon;
    return this;
  }

  _AlertListBottomSheetBuilder iconColor(Color iconColor) {
    this._iconColor = iconColor;
    return this;
  }

  _AlertListBottomSheetBuilder titleStyle(TextStyle titleStyle) {
    this._titleStyle = titleStyle;
    return this;
  }

  _AlertListBottomSheetBuilder subtitleStyle(TextStyle subtitleStyle) {
    this._subtitleStyle = subtitleStyle;
    return this;
  }

  _AlertListBottomSheetBuilder negative(String negativeBtnText, VoidCallback negativeBtnClickAction,
      {AppButtonStyle negativeBtnStyle}) {
    this.negativeBtnClickAction = negativeBtnClickAction;
    this.negativeBtnText = negativeBtnText;
    this._negativeBtnStyle = negativeBtnStyle;
    return this;
  }

  _AlertListBottomSheetBuilder positive(String positiveBtnText, VoidCallback positiveBtnClickAction,
      {AppButtonStyle positiveBtnStyle}) {
    this.positiveBtnClickAction = positiveBtnClickAction;
    this.positiveBtnText = positiveBtnText;
    this._positiveBtnStyle = positiveBtnStyle;
    return this;
  }

  _AlertListBottomSheetBuilder dismissible(bool dismissible) {
    this._dismissible = dismissible;
    return this;
  }

  _AlertListBottomSheetBuilder hasDivider(bool hasDivider) {
    this._hasDivider = hasDivider;
    return this;
  }

  _AlertListBottomSheetBuilder items(List<BottomSheetListItem> widgets) {
    _items.addAll(widgets);
    return this;
  }

  _AlertListBottomSheetBuilder item({
    String title,
    Widget titleWidget,
    IconData icon,
    TextStyle titleStyle,
    Color iconColor,
    Function onTap,
    bool closeDialogOnTap,
    dynamic tag,
  }) {
    _items.add(BottomSheetListItem(
      title: title,
      titleWidget: titleWidget,
      icon: icon,
      titleStyle: titleStyle,
      iconColor: iconColor,
      onTap: onTap,
      closeDialogOnTap: closeDialogOnTap,
      tag: tag,
    ));
    return this;
  }

  void show(BuildContext myContext) {
    showModalBottomSheet(
        context: myContext,
        isDismissible: _dismissible ?? true,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        )),
        builder: (context) {
          return _WidgetListBottomSheetWidget(
              context,
              _title,
              _titleWidget,
              _subtitle,
              _icon,
              _titleStyle,
              _subtitleStyle,
              _iconColor,
              positiveBtnText,
              _positiveBtnStyle,
              negativeBtnText,
              _negativeBtnStyle,
              positiveBtnClickAction,
              negativeBtnClickAction,
              _hasDivider ?? false,
              _items);
        });
  }
}

class ErrorAlertDialogDialogBuilder {
  String _title;
  String _message;

  String negativeBtnText = "core:dialogs:close";
  String positiveBtnText = "core:dialogs:copy";
  String errorTitleText = "core:dialogs:error";

  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;

  ErrorAlertDialogDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  ErrorAlertDialogDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  ErrorAlertDialogDialogBuilder error(dynamic error) {
    if (error != null) {
      if (error is String && error.isNotEmpty == true) {
        this._message = ExampleApp.getInstance().translateError(error);
      } else if (error is ErrorMessage) {
        this._message = ExampleApp.getInstance().translateError(error.toString());
      } else if (error is Error) {
        this._message = ErrorMessage.parse(error).messageText;
      } else if (error is Exception) {
        this._message = ErrorMessage.parse(error).messageText;
      } else {
        throw ErrorMessage("this type not supported");
      }
    } else {
      throw ErrorMessage("object must be not null.");
    }
    return this;
  }

  ErrorAlertDialogDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  ErrorAlertDialogDialogBuilder negative(String negativeBtnText, VoidCallback function) {
    this.negativeBtnClickAction = function;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  void show(BuildContext context) {
    AlertDialogDialogBuilder()
        .title(_title?.isNotEmpty == true ? _title : errorTitleText)
        .message(_message)
        .positive(
            positiveBtnText,
            positiveBtnClickAction != null
                ? positiveBtnClickAction
                : () {
                    Clipboard.setData(ClipboardData(text: _message));
                  })
        .negative(negativeBtnText, negativeBtnClickAction != null ? negativeBtnClickAction : () {})
        .show(context);
  }
}

class AlertDialogDialogBuilder {
  String _title;
  String _message;

  String positiveBtnText = "core:dialogs:accept";
  String negativeBtnText = "core:dialogs:cancel";

  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;

  bool _selectable = false;

  AlertDialogDialogBuilder selectable(bool value) {
    _selectable = value;
    return this;
  }

  AlertDialogDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  AlertDialogDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  AlertDialogDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  AlertDialogDialogBuilder negative(String negativeBtnText, VoidCallback function) {
    this.negativeBtnClickAction = function;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  AlertDialog _getAlert(BuildContext context) {
    TextStyle messageStyle = ExampleTheme.getTheme().textStyle.paragraph(color: Colors.black54);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: MyText(_title, style: ExampleTheme.getTheme().textStyle.caption()),
      content: _message.isNotEmpty
          ? Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: _selectable == true
                  ? SelectableText(
                      _message,
                      style: messageStyle,
                      onTap: () => Clipboard.setData(ClipboardData(text: _message)),
                    )
                  : MyText(_message, style: messageStyle),
            )
          : Container(),
      actions: <Widget>[
        negativeBtnClickAction != null
            ? FlatButton(
                onPressed: () {
                  Mold.onContextBackPressed(context);
                  negativeBtnClickAction.call();
                },
                child: MyText(negativeBtnText.translate(),
                    style: ExampleTheme.getTheme().textStyle.button(color: Colors.blue)))
            : Container(),
        positiveBtnClickAction != null
            ? FlatButton(
                onPressed: () {
                  Mold.onContextBackPressed(context);
                  positiveBtnClickAction.call();
                },
                child: MyText(positiveBtnText.translate(),
                    style: ExampleTheme.getTheme().textStyle.button(color: Colors.blue)))
            : Container(),
      ],
    );
  }

  void show(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(context: context, builder: (_) => _getCupertinoAlert(context));
    } else {
      showDialog(context: context, builder: (_) => _getAlert(context));
    }
  }

  Widget _getCupertinoAlert(BuildContext context) {
    return CupertinoAlertDialog(
      title: MyText(_title,
          style: ExampleTheme.getTheme().textStyle.paragraph(), textAlign: TextAlign.center),
      content: _message.isNotEmpty
          ? MyText(
              _message,
              style: ExampleTheme.getTheme().textStyle.paragraph(),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              textAlign: TextAlign.center,
            )
          : Container(),
      actions: <Widget>[
        negativeBtnClickAction != null
            ? CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Mold.onContextBackPressed(context);
                  negativeBtnClickAction.call();
                },
                child: MyText(
                  negativeBtnText,
                  style: ExampleTheme.getTheme()
                      .textStyle
                      .button(color: CupertinoColors.destructiveRed),
                ))
            : Container(),
        positiveBtnClickAction != null
            ? CupertinoDialogAction(
                onPressed: () {
                  Mold.onContextBackPressed(context);
                  positiveBtnClickAction.call();
                },
                child: MyText(
                  positiveBtnText,
                  style:
                      ExampleTheme.getTheme().textStyle.button(color: CupertinoColors.activeBlue),
                ))
            : Container(),
      ],
    );
  }
}

class NewAlertBottomSheetDialogBuilder {
  String _title;
  String _message;

  RouteSettings _routeSettings;
  String _routeName;

  String positiveBtnText = "core:dialogs:accept";
  String negativeBtnText = "core:dialogs:cancel";
  String optionalBtnText = "";

  VoidCallback positiveBtnClickAction;
  VoidCallback negativeBtnClickAction;
  VoidCallback optionalBtnClickAction;

  NewAlertBottomSheetDialogBuilder title(String _title) {
    this._title = _title;
    return this;
  }

  NewAlertBottomSheetDialogBuilder message(String _message) {
    this._message = _message;
    return this;
  }

  NewAlertBottomSheetDialogBuilder positive(String positiveBtnText, VoidCallback function) {
    this.positiveBtnClickAction = function;
    this.positiveBtnText = positiveBtnText;
    return this;
  }

  NewAlertBottomSheetDialogBuilder negative(String negativeBtnText, VoidCallback function) {
    this.negativeBtnClickAction = function;
    this.negativeBtnText = negativeBtnText;
    return this;
  }

  NewAlertBottomSheetDialogBuilder optional(String optionalBtnText, VoidCallback function) {
    this.optionalBtnClickAction = function;
    this.optionalBtnText = optionalBtnText;
    return this;
  }

  NewAlertBottomSheetDialogBuilder routeSettings(RouteSettings routeSetting) {
    this._routeSettings = routeSetting;
    return this;
  }

  NewAlertBottomSheetDialogBuilder routeName(String routeName) {
    this._routeName = routeName;
    return this;
  }

  Future<bool> show(BuildContext context) {
    final double bottomSafeArea = MediaQuery.of(context).padding.bottom;

    RouteSettings dialogRouteSettings;

    if (_routeSettings != null) {
      dialogRouteSettings = _routeSettings;
    }
    if (_routeName?.isNotEmpty == true && dialogRouteSettings == null) {
      dialogRouteSettings = RouteSettings(name: _routeName);
    }
    return showModalBottomSheet(
      context: context,
      backgroundColor: ExampleColor.getColor().background1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      routeSettings: dialogRouteSettings,
      builder: (context) => GLCard.container(
        showHeaderDivider: false,
        actionsDirection: Axis.vertical,
        background: ExampleColor.getColor().background1,
        margin: EdgeInsets.only(bottom: bottomSafeArea),
        header: _title?.isNotEmpty == true
            ? MyText(
                _title,
                style: ExampleTheme.getTheme()
                    .textStyle
                    .h5(color: ExampleColor.getColor().text.high_emphasis),
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                padding: EdgeInsets.all(16),
              )
            : null,
        body: _message?.isNotEmpty == true
            ? MyText(
                _message,
                style: ExampleTheme.getTheme()
                    .textStyle
                    .paragraph(color: ExampleColor.getColor().text.regular_medium),
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                padding: EdgeInsets.all(16),
              )
            : null,
        actions: <GLButton>[
          if (positiveBtnClickAction != null)
            GLButton.regular(
              text: positiveBtnText,
              style: ExampleTheme.getTheme().button_normal.primary1,
              onTap: () {
                Navigator.of(context).pop(true);
                positiveBtnClickAction?.call();
              },
            ),
          if (negativeBtnClickAction != null)
            GLButton.regular(
              text: negativeBtnText,
              style: ExampleTheme.getTheme().button_normal.regular2,
              onTap: () {
                Navigator.of(context).pop(false);
                negativeBtnClickAction?.call();
              },
            ),
          if (optionalBtnClickAction != null)
            GLButton.regular(
              text: optionalBtnText,
              style: ExampleTheme.getTheme().button_normal.regular2,
              onTap: () {
                Navigator.of(context).pop(null);
                optionalBtnClickAction?.call();
              },
            ),
        ],
      ),
    );
  }
}

class ConfirmationOption {
  final String title;
  final TextStyle titleStyle;
  final String subTitle;
  final TextStyle subTitleStyle;

  final VoidCallback clickAction;

  ConfirmationOption(
      {this.title, this.titleStyle, this.subTitle, this.subTitleStyle, this.clickAction});
}

class _BottomSheetConfirmationOption<T> {
  final String code;

  final String title;
  final TextStyle titleStyle;

  final String subTitle;
  final TextStyle subTitleStyle;

  final T tag;

  _BottomSheetConfirmationOption(this.code, this.title, this.subTitle,
      {this.tag, this.titleStyle, this.subTitleStyle});
}

class BottomSheetListItem {
  final String title;
  final Widget titleWidget;
  final IconData icon;
  final IconData rightIcon;
  final TextStyle titleStyle;
  final Color iconColor;
  final Color rightIconColor;
  final Function onTap;
  final bool closeDialogOnTap;
  final dynamic tag;

  BottomSheetListItem(
      {this.title,
      this.titleWidget,
      this.icon,
      this.rightIcon,
      this.titleStyle,
      this.iconColor,
      this.rightIconColor,
      this.onTap,
      this.closeDialogOnTap,
      this.tag});
}

class ProgressDialogBuilder {
  String _message;

  ProgressDialogBuilder message(String value) {
    _message = value;
    return this;
  }

  ProgressDialogController build(BuildContext context) {
    final message = _message ?? "core:dialog:please_wait_msg".translate();
    final alert = AlertDialog(
      content: MyTable.horizontal(
        [
          CircularProgressIndicator(),
          MyText(message, padding: EdgeInsets.only(left: 12), flex: 1),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
    return ProgressDialogController(context, alert);
  }
}

class ProgressDialogController {
  AlertDialog _dialog;
  BuildContext _context;
  Function hideAction;

  ProgressDialogController(this._context, this._dialog);

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          hideAction = () => Mold.onContextBackPressed(context);
          return _dialog;
        });
  }

  void hide() {
    if (hideAction != null) {
      hideAction.call();
    }
  }
}

// ignore: deprecated_extends_function
abstract class CommandFacade<T> extends Function {
  String getTitle(T obj);

  String getSubTitle(T obj);

  void apply(T obj);
}

void openSelectDateDialog(
  BuildContext context,
  String date,
  Function(DateTime) selectedAction, {
  DateTime firstDate,
  DateTime lastDate,
}) {
  if (firstDate != null && lastDate != null && firstDate.isAfter(lastDate))
    throw Exception("first date($firstDate) greate than last date($lastDate)");

  DateTime initialDate = DateUtil.tryParse(date) ?? DateTime.now();

  if (firstDate != null && initialDate.isBefore(firstDate)) {
    initialDate = firstDate;
  }

  if (lastDate != null && initialDate.isAfter(lastDate)) {
    initialDate = lastDate;
  }

  showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2100))
      .then((value) => {selectedAction.call(value)});
}

void openSelectRangeDateDialog(
  BuildContext context,
  String initialDate,
  Function(DateTimeRange) selectedAction, {
  DateTime firstDate,
  DateTime lastDate,
}) {
  DateTime start = DateTime.now();
  DateTime last = DateTime.now();
  if (initialDate?.isNotEmpty == true) {
    final splitDate = initialDate.split("-");
    start = DateUtil.tryParse(splitDate[0]) ?? DateTime.now();
    last = DateUtil.tryParse(splitDate[1]) ?? DateTime.now();
  }

  final initialDateRange = DateTimeRange(start: start, end: last);
  showDateRangePicker(
          context: context,
          initialDateRange: initialDateRange,
          firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 365)),
          lastDate: lastDate ?? DateTime(2030))
      .then((value) => {selectedAction.call(value)});
}

void openSelectTimeDialog(BuildContext context, String time, Function(TimeOfDay) selectedAction) {
  TimeOfDay consignTime = time?.isNotEmpty == true ? parseTime(time) : TimeOfDay.now();
  showTimePicker(context: context, initialTime: consignTime)
      .then((value) => {selectedAction.call(value)});
}

void openSelectTimeDialog_(
    BuildContext context, TimeOfDay time, Function(TimeOfDay) selectedAction) {
  showTimePicker(context: context, initialTime: time).then((value) => {selectedAction.call(value)});
}

typedef DialogsTitleFunction<E> = String Function(E element);
typedef DialogsSubTitleTitleFunction<E> = String Function(E element);
typedef DialogsItemSelectAction<E> = Function(E element);

TimeOfDay parseTime(String s) {
  if (s == null || s.length == 0) return null;
  try {
    switch (s.length) {
      case 5:
        return TimeOfDay.fromDateTime(DateUtil.FORMAT_AS_HH_MM.parse(s));
    }
    return TimeOfDay.fromDateTime(DateUtil.FORMAT_AS_TIME.parse(s));
  } on FormatException catch (error, st) {
    Log.error("Error($error)\n$st");
  }
  return null;
}

class _ConfirmationBottomSheetWidget<T> extends MoldStatefulWidget {
  final BuildContext mainContext;
  final String _title;
  final String positiveBtnText;
  final String negativeBtnText;
  final DialogsItemSelectAction<T> positiveBtnClickAction;
  final VoidCallback negativeBtnClickAction;
  final List<_BottomSheetConfirmationOption<T>> _options;

  LazyStream<_BottomSheetConfirmationOption<T>> _selectedOption = LazyStream();

  _ConfirmationBottomSheetWidget(
      this.mainContext,
      this._title,
      this._options,
      _BottomSheetConfirmationOption<T> selectedOption,
      this.positiveBtnText,
      this.negativeBtnText,
      this.positiveBtnClickAction,
      this.negativeBtnClickAction) {
    selectedOption?.let(_selectedOption.add);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.bottom;
    return StreamBuilder<_BottomSheetConfirmationOption<T>>(
        stream: _selectedOption.stream,
        builder: (_, snapshot) {
          return ClipRRect(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            clipBehavior: Clip.hardEdge,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(8),
                    topRight: const Radius.circular(8),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16 + safeArea),
                child: MyTable.vertical([
                  MyText(_title,
                      style: ExampleTheme.getTheme()
                          .textStyle
                          .title_4(color: ExampleColor.getColor().text.high_emphasis)),
                  SizedBox(height: 16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: ListBody(children: widgets(context, snapshot.data)),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey),
                  SizedBox(height: 12),
                  MyTable.vertical(
                    [
                      if (negativeBtnText?.isNotEmpty == true)
                        GLButton.regular(
                          text: negativeBtnText,
                          style: ExampleTheme.getTheme().button_normal.regular2,
                          onTap: () {
                            Mold.onContextBackPressed(context);
                            negativeBtnClickAction?.call();
                          },
                        ),
                      SizedBox(width: 8),
                      if (positiveBtnText?.isNotEmpty == true)
                        GLButton.regular(
                          text: positiveBtnText,
                          style: ExampleTheme.getTheme().button_normal.accent,
                          onTap: () {
                            if (_selectedOption?.value != null) {
                              Mold.onContextBackPressed(context);
                              positiveBtnClickAction?.call(_selectedOption?.value?.tag);
                            }
                          },
                        ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  )
                ])),
          );
        });
  }

  @override
  void onDestroy() {
    _selectedOption.close();
    super.onDestroy();
  }

  List<Widget> widgets(BuildContext context, _BottomSheetConfirmationOption<T> selectedOption) {
    return _options.map((e) {
      if (e.subTitle?.isNotEmpty == true) {
        return RadioListTile<_BottomSheetConfirmationOption<T>>(
          value: e,
          groupValue: selectedOption,
          onChanged: _selectedOption.add,
          title: MyText(e.title, style: ExampleTheme.getTheme().textStyle.paragraph()),
          subtitle: MyText(e.subTitle,
              style: ExampleTheme.getTheme().textStyle.caption(color: Colors.black54)),
        );
      } else {
        return RadioListTile<_BottomSheetConfirmationOption<T>>(
          value: e,
          groupValue: selectedOption,
          onChanged: _selectedOption.add,
          title: MyText(e.title, style: ExampleTheme.getTheme().textStyle.paragraph()),
        );
      }
    }).toList();
  }
}

class _NewConfirmationBottomSheetWidget<T> extends MoldStatefulWidget {
  final BuildContext mainContext;
  final String _title;
  final Widget _titleWidget;
  final TextStyle _titleStyle;
  final IconData _icon;
  final Color _iconColor;

  final bool _hasDivider;

  final String positiveBtnText;
  final AppButtonStyle positiveBtnStyle;
  final String negativeBtnText;
  final AppButtonStyle negativeBtnStyle;
  final DialogsItemSelectAction<T> positiveBtnClickAction;
  final VoidCallback negativeBtnClickAction;
  final List<_BottomSheetConfirmationOption<T>> _options;

  LazyStream<_BottomSheetConfirmationOption<T>> _selectedOption = LazyStream();

  _NewConfirmationBottomSheetWidget(
      this.mainContext,
      this._title,
      this._titleWidget,
      this._titleStyle,
      this._icon,
      this._iconColor,
      this._hasDivider,
      this._options,
      _BottomSheetConfirmationOption<T> selectedOption,
      this.positiveBtnText,
      this.positiveBtnStyle,
      this.negativeBtnText,
      this.negativeBtnStyle,
      this.positiveBtnClickAction,
      this.negativeBtnClickAction) {
    selectedOption?.let(_selectedOption.add);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.bottom;
    return StreamBuilder<_BottomSheetConfirmationOption<T>>(
        stream: _selectedOption.stream,
        builder: (_, snapshot) {
          return ClipRRect(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            clipBehavior: Clip.hardEdge,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4), topRight: Radius.circular(4))),
                padding: EdgeInsets.only(bottom: 8 + safeArea),
                child: MyTable.vertical([
                  if (_title != null || _titleWidget != null) _buildTitleWidget(),
                  if (_title != null || _titleWidget != null) SizedBox(height: 8),
                  Flexible(
                    child: SingleChildScrollView(
                      child: ListBody(children: widgets(context, snapshot.data)),
                    ),
                  ),
                  if (_hasDivider != true) Divider(height: 1, color: Colors.grey),
                  if (positiveBtnText?.isNotEmpty == true) SizedBox(width: 8),
                  if (positiveBtnText?.isNotEmpty == true)
                    GLButton.regular(
                      text: positiveBtnText,
                      upperCase: true,
                      style: positiveBtnStyle ?? ExampleTheme.getTheme().button_normal.accent,
                      width: double.infinity,
                      onTap: () {
                        if (_selectedOption?.value != null) {
                          Mold.onContextBackPressed(context);
                          positiveBtnClickAction?.call(_selectedOption?.value?.tag);
                        }
                      },
                    ),
                  if (negativeBtnText?.isNotEmpty == true) SizedBox(height: 8),
                  if (negativeBtnText?.isNotEmpty == true)
                    GLButton.regular(
                      text: negativeBtnText,
                      upperCase: true,
                      style: negativeBtnStyle ?? ExampleTheme.getTheme().button_normal.regular2,
                      width: double.infinity,
                      onTap: () {
                        Mold.onContextBackPressed(context);
                        negativeBtnClickAction?.call();
                      },
                    ),
                ])),
          );
        });
  }

  Widget _buildTitleWidget() {
    if (_titleWidget != null) return _titleWidget;

    return GLItem.build(
      title: _title,
      icon: _icon,
      iconColor: _iconColor,
      titleStyle: _titleStyle,
    );
  }

  List<Widget> widgets(BuildContext context, _BottomSheetConfirmationOption<T> selectedOption) {
    return _options.map((e) {
      Widget itemWidget = RadioListTile<_BottomSheetConfirmationOption<T>>(
        value: e,
        groupValue: selectedOption,
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: _selectedOption.add,
        title:
            MyText(e.title, style: e.titleStyle ?? ExampleTheme.getTheme().textStyle.paragraph()),
        subtitle: e.subTitle?.isNotEmpty == true
            ? MyText(e.subTitle,
                style: ExampleTheme.getTheme().textStyle.caption(color: Colors.black54))
            : null,
      );
      if (_hasDivider == true) {
        itemWidget = MyTable.vertical(
          [itemWidget, Divider(height: 0.5, color: ExampleColor.getColor().border.regular_low)],
        );
      }
      return itemWidget;
    }).toList();
  }

  @override
  void onDestroy() {
    _selectedOption.close();
    super.onDestroy();
  }
}

class _WidgetListBottomSheetWidget extends MoldStatefulWidget {
  final BuildContext mainContext;
  final String _title;
  final Widget _titleWidget;
  final String _subtitle;
  final IconData _icon;

  final TextStyle _titleStyle;
  final TextStyle _subtitleStyle;
  final Color _iconColor;

  final bool _hasDivider;

  final String positiveBtnText;
  final AppButtonStyle positiveBtnStyle;
  final String negativeBtnText;
  final AppButtonStyle negativeBtnStyle;
  final VoidCallback positiveBtnClickAction;
  final VoidCallback negativeBtnClickAction;
  final List<BottomSheetListItem> _items;

  _WidgetListBottomSheetWidget(
      this.mainContext,
      this._title,
      this._titleWidget,
      this._subtitle,
      this._icon,
      this._titleStyle,
      this._subtitleStyle,
      this._iconColor,
      this.positiveBtnText,
      this.positiveBtnStyle,
      this.negativeBtnText,
      this.negativeBtnStyle,
      this.positiveBtnClickAction,
      this.negativeBtnClickAction,
      this._hasDivider,
      this._items);

  @override
  Widget onCreateWidget(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding.bottom;
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
      clipBehavior: Clip.hardEdge,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4))),
          padding: EdgeInsets.only(bottom: 8 + safeArea),
          child: MyTable.vertical([
            if (_title != null || _titleWidget != null) _buildTitleWidget(),
            if (_title != null || _titleWidget != null) SizedBox(height: 8),
            Flexible(child: SingleChildScrollView(child: ListBody(children: widgets(context)))),
            if (_hasDivider != true) Divider(height: 1, color: Colors.grey),
            if (negativeBtnText?.isNotEmpty == true) SizedBox(height: 8),
            if (negativeBtnText?.isNotEmpty == true)
              GLButton.regular(
                text: negativeBtnText,
                upperCase: true,
                style: negativeBtnStyle ?? ExampleTheme.getTheme().button_normal.regular2,
                width: double.infinity,
                onTap: () {
                  Mold.onContextBackPressed(context);
                  negativeBtnClickAction?.call();
                },
              ),
            if (positiveBtnText?.isNotEmpty == true) SizedBox(width: 8),
            if (positiveBtnText?.isNotEmpty == true)
              GLButton.regular(
                text: positiveBtnText,
                upperCase: true,
                style: positiveBtnStyle ?? ExampleTheme.getTheme().button_normal.accent,
                width: double.infinity,
                onTap: () {
                  Mold.onContextBackPressed(context);
                  positiveBtnClickAction?.call();
                },
              ),
          ])),
    );
  }

  Widget _buildTitleWidget() {
    if (_titleWidget != null) return _titleWidget;

    return VItem.build(
      title: _title,
      icon: _icon,
      iconColor: _iconColor,
      titleStyle: _titleStyle,
      subtitle: _subtitle,
      subtitleStyle: _subtitleStyle,
    );
  }

  List<Widget> widgets(BuildContext context) {
    return _items.map((e) {
      if (e.titleWidget != null) {
        return e.titleWidget;
      }

      return VItem.build(
        title: e.title,
        icon: e.icon,
        iconColor: e.iconColor,
        rightIcon: e.rightIcon,
        rightIconColor: e.rightIconColor,
        titleStyle: e.titleStyle,
        verticalDivider: _hasDivider == true,
        onTap: () {
          if (e?.closeDialogOnTap == true) Mold.onContextBackPressed(context);
          e?.onTap?.call();
        },
      );
    }).toList();
  }
}
