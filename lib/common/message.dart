import 'package:dio/dio.dart';
import 'package:first_app/main.dart';
import 'package:first_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

abstract class Message {
  IconData _icon;

  Color _backgroundColor;
  Color _iconColor;
  Color _textColor;

  Message({
    IconData icon,
    Color backgroundColor,
    Color textColor,
    Color iconColor,
  }) {
    this._icon = icon ?? Icons.info_outline_rounded;
    this._backgroundColor = backgroundColor ?? ExampleColor.getColor().primary.primary_1;
    this._iconColor = iconColor ?? ExampleColor.getColor().text.on_primary_high_emphasis;
    this._textColor = textColor ?? ExampleColor.getColor().text.on_primary_high_emphasis;
  }

  String getMessage();

  IconData get icon => _icon;

  Color get backgroundColor => this._backgroundColor;

  Color get textColor => this._textColor;

  Color get iconColor => this._iconColor;
}

class ErrorMessage extends Message {
  static final ErrorMessage NULL = ErrorMessage(null);

  final String messageText;
  final String originalMessageText;
  final String stacktrace;
  final String httpCode;

  ErrorMessage(String message, {String stacktrace, String httpCode})
      : this.messageText = nvl(ExampleApp.getInstance().translateError(message)),
        this.originalMessageText = nvl(message),
        this.stacktrace = nvl(stacktrace),
        this.httpCode = nvl(httpCode),
        super(
          icon: Icons.warning,
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().status.error_regular,
        );

  @override
  String getMessage() => messageText;

  factory ErrorMessage.parse(dynamic error) {
    return ErrorMessage.parseWithStacktrace(error, "");
  }

  factory ErrorMessage.parseWithStacktrace(dynamic error, dynamic stacktrace) {
    String message = error.toString();
    String httpCode = "-1";
    if (error is DioError) {
      if (error.type == DioErrorType.response) {
        message = error.response.data.toString();
        if (message.trim().isEmpty) {
          message = error.message;
        }
        httpCode = error.response.statusCode.toString();
      }
    }
    return ErrorMessage(message?.trim(), stacktrace: stacktrace?.toString(), httpCode: httpCode);
  }

  bool get isNotEmptyMessage => messageText?.isNotEmpty == true;

  @override
  String toString() {
    if (stacktrace == null || stacktrace.trim().isEmpty) {
      return messageText;
    }
    return "$messageText\n$stacktrace";
  }
}

class WarningMessage extends Message {
  static String t(String key) => "gwslib:warning:$key".translate();

  static final WarningMessage NULL = WarningMessage(null);

  static String translate(String warning) {
    if (warning == null) return null;
    String war = warning.toLowerCase();
    return war;
  }

  final String message;
  final String description;

  WarningMessage(String message, {this.description})
      : this.message = nvl(translate(message)),
        super(
          icon: Icons.warning,
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().status.warning_regular,
        );

  @override
  String getMessage() => message;
}

class PrimaryMessage extends Message {
  final String description;
  final String message;

  @override
  String getMessage() => message;

  PrimaryMessage(this.message, {this.description})
      : super(
          icon: Icons.notifications,
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().new_primary,
        );
}

class SecondaryMessage extends Message {
  final String description;
  final String message;

  @override
  String getMessage() => message;

  SecondaryMessage(this.message, {this.description})
      : super(
          icon: Icons.notifications,
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().status.secondary,
        );
}

class SuccessMessage extends Message {
  final String description;
  final String message;

  @override
  String getMessage() => message;

  SuccessMessage(this.message, {this.description})
      : super(
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().status.success_regular,
          icon: Icons.check_circle,
        );
}

class InfoMessage extends Message {
  final String description;
  final String message;

  @override
  String getMessage() => message;

  InfoMessage(this.message, {this.description})
      : super(
          iconColor: ExampleColor.getColor().text.on_accent_high,
          textColor: ExampleColor.getColor().text.on_accent_high,
          backgroundColor: ExampleColor.getColor().status.info,
          icon: Icons.info,
        );
}
