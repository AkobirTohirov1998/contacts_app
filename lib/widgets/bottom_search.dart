import 'dart:io';

import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:first_app/widgets/edit_text.dart';
import 'package:flutter/material.dart';

class BottomSearchController extends VContainer {
  final SearchController searchController;

  BottomSearchController({@required this.searchController});

  @override
  Widget build(BuildContext context) {
    Widget widget = Row(
      children: [_getSearchTextField(), _closeButton()],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    widget = super.buildBox(
      widget,
      null,
      72,
      ExampleColor.getColor().block.surface_2,
      null,
      null,
      5,
      Colors.black12,
      Offset(0, -5),
    );

    if (Platform.isIOS) {
      final window = WidgetsBinding.instance.window;
      final data = MediaQueryData.fromWindow(window);

      widget = Container(
        color: ExampleColor.getColor().block.background,
        child: Padding(
          child: widget,
          padding: EdgeInsets.only(bottom: data.padding.bottom),
        ),
      );
    }

    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: widget,
    );
  }

  Widget _getSearchTextField() {
    return Expanded(
      child: VEditText(
        text: searchController.textEditingController.text,
        onChanged: searchController.onChange,
        hintText: searchController.hintText,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      flex: 1,
    );
  }

  Widget _closeButton() {
    return Container(
      child: VButton.normal(
        icon: Icons.close,
        style: ExampleTheme.getTheme().button_normal.primary3,
        onTap: searchController.closeAction,
      ),
      margin: EdgeInsets.all(8),
    );
  }
}

class SearchController {
  final TextEditingController textEditingController;
  final FocusNode searchFocusNode;
  String hintText;
  void Function() closeAction;
  OnQueryCallback onChange;
  IconData rightIcon;
  void Function() onRightTap;

  SearchController({
    @required this.onChange,
    TextEditingController textEditingController,
    this.hintText,
    this.closeAction,
    this.rightIcon,
    this.onRightTap,
  })  : this.textEditingController = textEditingController ?? TextEditingController(),
        this.searchFocusNode = FocusNode();

  void dispose() {
    textEditingController.dispose();
    searchFocusNode.dispose();
  }
}
