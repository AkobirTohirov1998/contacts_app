import 'dart:math';

import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

enum CircleProgressSize { small, medium, large, huge }

class GLCircularProgress extends VContainer {
  static const double CIRCLE_PROGRESS_SIZE_SMALL = 32;
  static const double CIRCLE_PROGRESS_SIZE_MEDIUM = 48;
  static const double CIRCLE_PROGRESS_SIZE_BIG = 73;
  static const double CIRCLE_PROGRESS_SIZE_LARGE = 110;
  static const double CIRCLE_PROGRESS_SIZE_HUGE = 136;

  double value;
  double size;
  Color progressColor;
  Color progressBackgroundColor;
  Animation<Color> animationColor;
  double stockWidth;
  Widget child;

  GLCircularProgress({
    this.value,
    @required this.size,
    double stockWidth,
    Color progressColor,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
    this.child,
  })  : progressColor = progressColor ?? ExampleColor.getColor().accent,
        progressBackgroundColor = progressBackgroundColor ?? ExampleColor.getColor().regular,
        animationColor = animationColor ?? AlwaysStoppedAnimation(progressColor),
        stockWidth = stockWidth ?? 4.0;

  factory GLCircularProgress.withText({
    double value,
    @required CircleProgressSize size,
    @required Stream<String> textStream,
    TextStyle textStyle,
    Color progressColor,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
    double stockWidth,
  }) {
    double progressSize = getSize(size);

    Widget wText;
    if (textStream != null) {
      TextStyle textStyleBySize = getTextStyleBySize(size);
      wText = StreamBuilder(
          stream: textStream,
          builder: (context, snapshot) {
            return Container(
              child: MyText(
                snapshot?.data ?? "",
                style: textStyle ?? textStyleBySize,
                alignment: Alignment.center,
              ),
            );
          });
    }
    return GLCircularProgress(
      value: value,
      size: progressSize,
      progressColor: progressColor,
      progressBackgroundColor: progressBackgroundColor,
      animationColor: animationColor,
      stockWidth: stockWidth ?? stockWidthBySize(size),
      child: wText,
    );
  }

  factory GLCircularProgress.small({
    @required double value,
    Widget child,
    Color progressColor,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
  }) {
    return GLCircularProgress(
      value: value,
      child: child,
      size: getSize(CircleProgressSize.small),
      progressColor: progressColor,
      progressBackgroundColor: progressBackgroundColor,
      animationColor: animationColor,
      stockWidth: stockWidthBySize(CircleProgressSize.small),
    );
  }

  factory GLCircularProgress.medium({
    @required double value,
    Stream<String> textStream,
    Widget child,
    Color progressColor,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
  }) {
    if (child == null && textStream != null) {
      return GLCircularProgress.withText(
        value: value,
        textStream: textStream,
        size: CircleProgressSize.medium,
        progressColor: progressColor,
        progressBackgroundColor: progressBackgroundColor,
        animationColor: animationColor,
        stockWidth: stockWidthBySize(CircleProgressSize.medium),
      );
    }

    return GLCircularProgress(
      value: value,
      size: getSize(CircleProgressSize.medium),
      child: child,
      progressColor: progressColor,
      progressBackgroundColor: progressBackgroundColor,
      animationColor: animationColor,
      stockWidth: stockWidthBySize(CircleProgressSize.medium),
    );
  }

  factory GLCircularProgress.large({
    @required double value,
    Stream<String> textStream,
    Color progressColor,
    Widget child,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
  }) {
    if (child == null && textStream != null) {
      return GLCircularProgress.withText(
        value: value,
        textStream: textStream,
        size: CircleProgressSize.large,
        progressColor: progressColor,
        progressBackgroundColor: progressBackgroundColor,
        animationColor: animationColor,
        stockWidth: stockWidthBySize(CircleProgressSize.large),
      );
    }

    return GLCircularProgress(
      value: value,
      child: child,
      size: getSize(CircleProgressSize.large),
      progressColor: progressColor,
      progressBackgroundColor: progressBackgroundColor,
      animationColor: animationColor,
      stockWidth: stockWidthBySize(CircleProgressSize.large),
    );
  }

  factory GLCircularProgress.huge({
    @required double value,
    Stream<String> textStream,
    Color progressColor,
    Widget child,
    Color progressBackgroundColor,
    Animation<Color> animationColor,
  }) {
    if (child == null && textStream != null) {
      return GLCircularProgress.withText(
        value: value,
        textStream: textStream,
        size: CircleProgressSize.huge,
        progressColor: progressColor,
        progressBackgroundColor: progressBackgroundColor,
        animationColor: animationColor,
        stockWidth: stockWidthBySize(CircleProgressSize.huge),
      );
    }

    return GLCircularProgress(
      value: value,
      child: child,
      size: getSize(CircleProgressSize.huge),
      progressColor: progressColor,
      progressBackgroundColor: progressBackgroundColor,
      animationColor: animationColor,
      stockWidth: stockWidthBySize(CircleProgressSize.huge),
    );
  }

  Widget onCreateWidget(BuildContext context) {
    if (animationColor is AlwaysStoppedAnimation) {
      return CustomPaint(
        foregroundPainter: RadialPainter(
            bgColor: progressBackgroundColor,
            lineColor: progressColor,
            percent: value,
            width: stockWidth),
        child: Container(
          child: child,
          height: size,
          width: size,
          padding: EdgeInsets.all(stockWidth),
        ),
        size: Size(size, size),
      );
    }

    Widget widget = Container(
      child: CircularProgressIndicator(
        value: value,
        valueColor: animationColor,
        strokeWidth: stockWidth,
        backgroundColor: progressBackgroundColor,
        color: progressColor,
      ),
      width: size,
      height: size,
    );

    if (child != null) {
      widget = Stack(children: [
        widget,
        Container(child: child, height: size - 2 * stockWidth, width: size - 2 * stockWidth),
      ], alignment: Alignment.center);
    }

    return widget;
  }

  static double getSize(CircleProgressSize progressSize) {
    if (progressSize != null) {
      switch (progressSize) {
        case CircleProgressSize.small:
          return CIRCLE_PROGRESS_SIZE_SMALL;
        case CircleProgressSize.medium:
          return CIRCLE_PROGRESS_SIZE_MEDIUM;
        case CircleProgressSize.large:
          return CIRCLE_PROGRESS_SIZE_LARGE;
        case CircleProgressSize.huge:
          return CIRCLE_PROGRESS_SIZE_HUGE;
      }
    }
    return getSize(CircleProgressSize.small);
  }

  static double stockWidthBySize(CircleProgressSize progressSize) {
    if (progressSize != null) {
      switch (progressSize) {
        case CircleProgressSize.small:
          return 2;
        case CircleProgressSize.medium:
          return 2;
        case CircleProgressSize.large:
          return 4;
        case CircleProgressSize.huge:
          return 8;
      }
    }
    return stockWidthBySize(CircleProgressSize.small);
  }

  static TextStyle getTextStyleBySize(CircleProgressSize progressSize) {
    if (progressSize != null) {
      switch (progressSize) {
        case CircleProgressSize.small:
          return ExampleTheme.getTheme().textStyle.h6(color: ExampleColor.getColor().accent);
        case CircleProgressSize.medium:
          return ExampleTheme.getTheme().textStyle.h6(color: ExampleColor.getColor().accent);
        case CircleProgressSize.large:
          return ExampleTheme.getTheme().textStyle.h5(color: ExampleColor.getColor().accent);
        case CircleProgressSize.huge:
          return ExampleTheme.getTheme().textStyle.h1(color: ExampleColor.getColor().accent);
      }
    }
    return getTextStyleBySize(CircleProgressSize.small);
  }
}

class RadialPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double width;
  final double percent;

  RadialPainter({this.bgColor, this.lineColor, this.width, this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = new Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint completedLine = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = Offset(size.width / 2, size.height / 2);

    double radius = min(size.width / 2, size.height / 2);

    double sweepAngle = 2 * pi * percent;

    Rect rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(center, radius, bgLine);

    canvas.drawArc(rect, 3 * pi / 2, sweepAngle, false, completedLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
