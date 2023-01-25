import 'dart:math';

import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/bottom_search.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

// ignore: must_be_immutable
class VBottomNavigation extends VContainer {
  static String t(String key) => "account:widgets:$key".translate();

  factory VBottomNavigation.withBackPress({
    @required BuildContext screenContext,
    @required List<ButtonAction> actions,
    MainAxisAlignment mainAxisAlignment,
    SearchController searchController,
  }) {
    List<ButtonAction> finalActions = [
      if (Navigator.canPop(screenContext))
        ButtonAction.action(
          Icons.arrow_back,
          t("back_btn"),
          ExampleTheme.getTheme().bottomNavigation.defaults,
          () => Mold.onContextBackPressed(screenContext),
        ),
    ];
    finalActions.addAll(actions);
    return VBottomNavigation(
      actions: finalActions,
      searchController: searchController,
      mainAxisAlignment: mainAxisAlignment,
    );
  }

  final List<ButtonAction> actions;
  final MainAxisAlignment mainAxisAlignment;
  final SearchController searchController;

  VBottomNavigation({
    @required this.actions,
    this.mainAxisAlignment,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final List<ButtonAction> buttomActions = <ButtonAction>[...actions];
    if (searchController != null) {
      final search = ButtonAction.action(
        Icons.search,
        t("search"),
        ExampleTheme.getTheme().bottomNavigation.defaults,
        () {
          searchController.closeAction?.call();
        },
      );
      buttomActions.add(search);
    }
    if (buttomActions.isEmpty) {
      return const SizedBox(width: 1, height: 1);
    }

    final window = WidgetsBinding.instance.window;
    final mediaQueryData = MediaQueryData.fromWindow(window);

    Widget widget = Row(
      children: buttomActions.map((e) => buildItem(e)).toList(),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
    );

    final double bottomPadding = max(0, mediaQueryData.padding.bottom - 15);

    widget = super.buildBox(
      widget,
      null,
      72 + bottomPadding,
      ExampleColor.getColor().block.surface_2,
      null,
      null,
      2,
      Colors.black12,
      const Offset(0, -1),
      EdgeInsets.only(bottom: bottomPadding),
    );

    widget = Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: MediaQuery.of(context).viewInsets.bottom > mediaQueryData.padding.bottom
          ? buildKeyboardToolbar(context)
          : widget,
    );
    return widget;
  }

  Widget buildItem(ButtonAction action) {
    Widget widget = Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            MyIcon.icon(
              action.icon,
              size: 20,
              color: action.style.iconColor,
            ),
            const SizedBox(height: 4),
            MyText(
              action.text,
              style: ExampleTheme.getTheme().textStyle.caption(color: action.style.textColor),
              alignment: Alignment.center,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      color: action.style.background,
      height: double.infinity,
      constraints: const BoxConstraints(maxWidth: 82),
    );

    widget = super.buildOnTap(widget, action.onTap);

    widget = super.buildExpanded(widget, action.flex);

    return widget;
  }

  Widget buildKeyboardToolbar(BuildContext context) {
    Widget widget = MyTable.vertical(
      [
        const Divider(height: 1, color: Colors.black12),
        MyText(
          "Done",
          style: ExampleTheme.getTheme()
              .textStyle
              .paragraphBold(color: ExampleColor.getColor().accent),
          onTap: () => Mold.hideKeyboard(),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
    );

    return super.buildBox(
      widget,
      null,
      null,
      ExampleColor.getColor().background2,
      null,
      null,
      null,
      null,
      Offset.zero,
    );
  }
}

class ButtonAction {
  factory ButtonAction.navigation(
    IconData icon,
    String text,
    AppBottomNavigationStyle style,
    VoidCallback onTap, {
    Color background,
  }) {
    return ButtonAction(icon, text, background, style, onTap, flex: 1);
  }

  factory ButtonAction.action(
    IconData icon,
    String text,
    AppBottomNavigationStyle style,
    VoidCallback onTap, {
    Color background,
  }) {
    return ButtonAction(icon, text, background, style, onTap, flex: null);
  }

  final IconData icon;
  final String text;
  final Color background;
  final AppBottomNavigationStyle style;
  final VoidCallback onTap;
  final int flex;

  ButtonAction(
    this.icon,
    this.text,
    this.background,
    this.style,
    this.onTap, {
    this.flex,
  });
}

class GLBottomNavigation extends VContainer {
  static String t(String key) => "account:widgets:$key".translate();

  factory GLBottomNavigation.withBackPress({
    @required BuildContext screenContext,
    @required List<GLButtonAction> actions,
    MainAxisAlignment mainAxisAlignment,
    SearchController searchController,
    bool isToolbarEnabled = true,
  }) {
    List<GLButtonAction> finalActions = [
      if (Navigator.canPop(screenContext))
        GLButtonAction.action(
            Icons.arrow_back,
            t("back_btn"),
            ExampleTheme.getTheme().bottomNavigation.defaults,
            () => Mold.onContextBackPressed(screenContext),
            direction: Axis.vertical),
    ];
    finalActions.addAll(actions);
    return GLBottomNavigation(
      actions: finalActions,
      searchController: searchController,
      mainAxisAlignment: mainAxisAlignment,
      isToolbarEnabled: isToolbarEnabled,
    );
  }

  final List<GLButtonAction> actions;
  final MainAxisAlignment mainAxisAlignment;
  final SearchController searchController;
  final bool isToolbarEnabled;
  final Color background;

  GLBottomNavigation({
    @required this.actions,
    this.mainAxisAlignment,
    this.searchController,
    this.isToolbarEnabled = true,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    final List<GLButtonAction> buttomActions = <GLButtonAction>[...actions];
    if (searchController != null) {
      final search = GLButtonAction.action(
        Icons.search,
        t("search"),
        ExampleTheme.getTheme().bottomNavigation.defaults,
        () {
          searchController.closeAction?.call();
        },
      );
      buttomActions.add(search);
    }

    final window = WidgetsBinding.instance.window;
    final mediaQueryData = MediaQueryData.fromWindow(window);

    Widget widget = const SizedBox(width: 1, height: 1);

    if (buttomActions?.isNotEmpty == true) {
      widget = Row(
        children: buttomActions.map((e) => buildItem(e)).toList(),
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      );

      final double bottomPadding = max(0, mediaQueryData.padding.bottom - 20);

      widget = super.buildBox(
        widget,
        null,
        72 + bottomPadding,
        background ?? ExampleColor.getColor().background2,
        null,
        null,
        null,
        null,
        Offset.zero,
        EdgeInsets.only(bottom: bottomPadding),
      );
    }

    if (isToolbarEnabled == true &&
        MediaQuery.of(context).viewInsets.bottom > mediaQueryData.padding.bottom) {
      widget = buildKeyboardToolbar(context);
    }
    return widget;
  }

  Widget buildItem(GLButtonAction action) {
    Widget iconWidget;
    if (action.icon != null) {
      iconWidget = MyIcon.icon(
        action.icon,
        size: 24,
        color: action.style.iconColor,
      );
    }

    TextStyle textStyle;
    if (action.direction == Axis.vertical) {
      textStyle = ExampleTheme.getTheme().textStyle.caption(color: action.style.textColor);
    } else {
      textStyle = ExampleTheme.getTheme().textStyle.buttonRegular(color: action.style.textColor);
    }
    Widget textWidget;
    if (action.text?.isNotEmpty == true) {
      textWidget = MyText(
        action.text,
        style: textStyle,
        alignment: Alignment.center,
        textOverflow: TextOverflow.ellipsis,
      );
    }
    Widget widget;
    if (action.direction == Axis.vertical) {
      Widget spacer;
      if (action.icon != null && action.text != null) {
        spacer = const SizedBox(height: 8);
      }

      widget = Column(
        children: [
          iconWidget,
          spacer,
          textWidget,
        ].where((element) => element != null).toList(),
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    } else {
      Widget spacer;
      if (action.icon != null && action.text != null) {
        spacer = const SizedBox(width: 8);
      }

      widget = Row(
        children: [
          iconWidget,
          spacer,
          textWidget,
        ].where((element) => element != null).toList(),
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }

    widget = Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: widget,
      ),
      color: action.style.background,
      height: double.infinity,
      constraints: const BoxConstraints(maxWidth: 82, minWidth: 72),
    );

    widget = super.buildOnTap(widget, action.onTap);

    widget = super.buildExpanded(widget, action.flex);

    return widget;
  }

  Widget buildKeyboardToolbar(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Divider(height: 1, color: Colors.black12),
          MyText(
            "Done",
            style: ExampleTheme.getTheme()
                .textStyle
                .paragraphBold(color: ExampleColor.getColor().accent),
            onTap: () {
              FocusManager.instance?.primaryFocus?.unfocus();
              Mold.hideKeyboard();
            },
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      height: MediaQuery.of(context).viewInsets.bottom + 44,
      color: ExampleColor.getColor().background2,
    );
  }
}

class GLButtonAction {
  factory GLButtonAction.navigation(
    IconData icon,
    String text,
    AppBottomNavigationStyle style,
    VoidCallback onTap, {
    Color background,
    Axis direction = Axis.vertical,
  }) {
    return GLButtonAction(
      icon,
      text,
      background,
      style,
      onTap,
      direction: direction,
      flex: 1,
    );
  }

  factory GLButtonAction.action(
    IconData icon,
    String text,
    AppBottomNavigationStyle style,
    VoidCallback onTap, {
    Color background,
    Axis direction = Axis.vertical,
  }) {
    return GLButtonAction(
      icon,
      text,
      background,
      style,
      onTap,
      direction: direction,
      flex: null,
    );
  }

  final IconData icon;
  final String text;
  final Color background;
  final AppBottomNavigationStyle style;
  final VoidCallback onTap;
  final Axis direction;
  final int flex;

  GLButtonAction(
    this.icon,
    this.text,
    this.background,
    this.style,
    this.onTap, {
    this.flex,
    this.direction = Axis.vertical,
  });
}
