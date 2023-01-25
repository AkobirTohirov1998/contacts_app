import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';

class GLLinerProgress extends VContainer {
  Stream<String> textStream;
  ProgressTextAlignment textAlignment;
  TextStyle textStyle;
  Color progressColor;
  Color progressBackgroundColor;
  double value;
  double borderRadius;
  double borderWidth;
  Animation<Color> animationColor;
  double height;

  GLLinerProgress({
    @required this.value,
    this.textStream,
    this.textStyle,
    this.textAlignment,
    this.progressColor,
    this.borderRadius,
    this.borderWidth,
    this.height = 8,
    this.animationColor,
    this.progressBackgroundColor,
  });

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget indicator = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
        border: Border.all(color: progressColor, width: borderWidth ?? 0.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: LinearProgressIndicator(
        backgroundColor: progressBackgroundColor ?? ExampleColor.getColor().regular,
        value: value ?? 0.0,
        valueColor: animationColor ??
            new AlwaysStoppedAnimation<Color>(progressColor ?? ExampleColor.getColor().accent),
        minHeight: height ?? 8,
      ),
    );

    Widget wText;
    if (textStream != null) {
      wText = StreamBuilder<String>(
        stream: textStream,
        builder: (context, snapshot) {
          return snapshot?.data?.isNotEmpty == true
              ? Text(snapshot.data,
                  style: textStyle ??
                      ExampleTheme.getTheme()
                          .textStyle
                          .table(color: ExampleColor.getColor().text.regular_high),
                  overflow: TextOverflow.ellipsis)
              : Container(height: 0.0, width: 0.0);
        },
      );
    }
    List<Widget> widgets = [];

    Widget wHspacer;
    Widget wWspacer;

    if (wText != null) {
      wHspacer = SizedBox(height: 8);
      wWspacer = SizedBox(width: 8);
    }

    Axis axis;
    switch (textAlignment) {
      case ProgressTextAlignment.top:
        axis = Axis.vertical;
        widgets = [wText, wHspacer, indicator];
        break;
      case ProgressTextAlignment.left:
        axis = Axis.horizontal;
        widgets = [wText, wWspacer, Expanded(child: indicator)];
        break;
      case ProgressTextAlignment.right:
        axis = Axis.horizontal;
        widgets = [Expanded(child: indicator), wWspacer, wText];
        break;
      case ProgressTextAlignment.bottom:
        axis = Axis.vertical;
        widgets = [indicator, wHspacer, wText];
        break;
    }
    widgets.removeWhere((e) => e == null);
    Widget widget;
    if (axis == Axis.vertical) {
      widget = Column(children: widgets);
    } else {
      widget = Row(children: widgets);
    }
    return Container(margin: EdgeInsets.all(8), child: widget);
  }
}

enum ProgressTextAlignment {
  top,
  left,
  right,
  bottom,
}
