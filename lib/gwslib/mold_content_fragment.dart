import 'dart:async' as async;

import 'package:first_app/common/resources.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

abstract class MoldContentFragment<VM extends ViewModel> extends ViewModelFragment<VM> {
  MyAppBar buildToolbar(
      {dynamic leading, dynamic title, String subTitle, List<MenuItem> menus, Color background}) {
    Widget leadingWidget;
    if (leading is Widget) {
      leadingWidget = leading;
    } else if (leading is GlobalKey<ScaffoldState>) {
      GlobalKey<ScaffoldState> key = leading;
      leadingWidget = IconButton(
        icon: MyIcon.svg(
          AssertsSvg.drawer_menu,
          color: AssertsColors.toolbar_icon_color,
        ),
        onPressed: () => key.currentState.openDrawer(),
      );
    } else if (Navigator.of(getContext()).canPop()) {
      leadingWidget = IconButton(
        icon: MyIcon.svg(
          AssertsSvg.leading_back,
          color: AssertsColors.toolbar_icon_color,
        ),
        onPressed: () => Navigator.of(getContext()).pop(),
      );
    }

    Widget titleWidget;
    if (title is Widget) {
      titleWidget = title;
    } else if (title is String) {
      titleWidget = MyText(
        title,
        style: ExampleTheme.getTheme().textStyle.title_5(color: AssertsColors.toolbar_icon_color),
      );
    }

    List<Widget> toolbarActions = [];
    if (menus != null && menus.isNotEmpty) {
      // search action
      //

      // default icon action
      toolbarActions.addAll(menus.where((it) => it.isIcon()).map((it) => it.toWidget()));

      // submenu actions
      List<MenuItem> subMenus = menus.where((it) => it.isSub()).toList();
      if (subMenus.isNotEmpty) {
        toolbarActions.add(PopupMenuButton<int>(
          icon: MyIcon.icon(
            Icons.more_vert,
            color: AssertsColors.toolbar_icon_color,
          ),
          onSelected: (index) => subMenus[index].callback.call(),
          itemBuilder: (context) {
            List<PopupMenuItem<int>> popupList = [];
            for (int i = 0; i < subMenus.length; i++) {
              final subItem = subMenus[i];
              popupList.add(PopupMenuItem<int>(value: i, child: MyText(subItem.text)));
            }
            return popupList;
          },
        ));
      }
    }
    return new MyAppBar(
      leading: leadingWidget,
      title: titleWidget,
      actions: toolbarActions,
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: background ?? AssertsColors.toolbar_color,
    );
  }
}

class MenuItem {
  static final int ICON = 1;
  static final int SUB = 2;
  static final int SEARCH = 3;

  final int type;
  final Widget widget;
  final Widget icon;
  final String text;
  final String hintText;
  final VoidCallback callback;

  MenuItem({this.type, this.widget, this.icon, this.text, this.hintText, this.callback});

  factory MenuItem.icon({dynamic icon, String hintText, VoidCallback callback}) {
    Widget iconWidget = icon is IconData ? MyIcon.icon(icon) : MyIcon.svg(icon);
    return MenuItem(type: ICON, icon: iconWidget, hintText: hintText ?? "", callback: callback);
  }

  factory MenuItem.sub({String text, VoidCallback callback}) {
    return MenuItem(type: SUB, text: text, callback: callback);
  }

  bool isIcon() => type == ICON;

  bool isSub() => type == SUB;

  Widget toWidget() {
    final color = AssertsColors.toolbar_icon_color;
    return widget ?? IconButton(icon: icon, color: color, tooltip: text, onPressed: callback);
  }
}

class SearchMenuItem extends MenuItem {
  final String query;
  final OnQueryCallback _onQueryCallback;
  final OnTextChangeCallback _onTextChangeCallback;
  final Duration textChangeDuration;

  SearchMenuItem({
    this.query,
    OnQueryCallback onQueryCallback,
    OnTextChangeCallback onTextChangeCallback,
    this.textChangeDuration = const Duration(milliseconds: 500),
    Widget icon,
    String text,
    String hintText,
    VoidCallback onSearchClickAction,
  })  : this._onTextChangeCallback = onTextChangeCallback,
        this._onQueryCallback = onQueryCallback,
        super(
            type: MenuItem.ICON,
            icon: icon ?? MyIcon.icon(Icons.search),
            text: text ?? ("account:bottom_menu_widget:search").translate(),
            hintText: hintText,
            callback: onSearchClickAction);

  Widget toSearchWidget(VoidCallback clickAction) {
    final color = AssertsColors.toolbar_icon_color;
    return widget ?? IconButton(icon: icon, color: color, tooltip: text, onPressed: clickAction);
  }

  async.Timer queryChangedTimer;

  void queryChanged(String query) {
    queryChangedTimer?.cancel();
    queryChangedTimer = async.Timer(textChangeDuration, () {
      _onTextChangeCallback?.call(query);
      queryChangedTimer = null;
    });
  }

  void notifyText(String query) {
    queryChangedTimer?.cancel();
    _onTextChangeCallback?.call(query);
    _onQueryCallback?.call(query);
  }
}
