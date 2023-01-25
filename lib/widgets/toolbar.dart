import 'dart:math';

import 'package:first_app/common/resources.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/bottom_search.dart';
import 'package:first_app/widgets/button.dart';
import 'package:first_app/widgets/container.dart';
import 'package:first_app/widgets/edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/common/setter.dart';
import 'package:gwslib/gwslib.dart';
import 'package:rxdart/rxdart.dart';

class VToolbarSearch extends VContainer implements PreferredSizeWidget {
  final Size preferredSize;

  final BuildContext context;

  final SearchController searchController;

  BehaviorSubject<String> _searchQuery;

  VToolbarSearch({@required this.context, @required this.searchController})
      : preferredSize = Size.fromHeight(77 + MediaQuery.of(context).padding.top);

  @override
  void onCreate() {
    super.onCreate();

    _searchQuery = BehaviorSubject.seeded(searchController.textEditingController?.text ?? "");

    _searchQuery.debounceTime(const Duration(milliseconds: 500)).listen(searchController.onChange);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    final topSafeArea = MediaQuery.of(context).padding.top;
    Widget widget = Container(
        child: Row(
          children: [_getSearchTextField(), _closeButton()],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        margin: EdgeInsets.only(top: topSafeArea));

    return super.buildBox(
      widget,
      null,
      77 + topSafeArea,
      ExampleColor.getColor().background,
      null,
      null,
      5,
      Colors.black12,
      const Offset(0, -5),
    );
  }

  Widget _getSearchTextField() {
    return Expanded(
      child: VEditText.searchField(
        textController: searchController.textEditingController,
        onChanged: _onChange,
        hintText: searchController.hintText,
        margin: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        onRightTap: searchController.onRightTap,
        rightIcon: searchController.rightIcon,
      ),
      flex: 1,
    );
  }

  Widget _closeButton() {
    return Container(
      child: VButton.normal(
        icon: Icons.close,
        style: ExampleTheme.getTheme().button_normal.primary3,
        onTap: _close,
        width: 35,
        height: 35,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.all(8),
    );
  }

  void _onChange(String text) {
    _searchQuery.addSafety(text);
  }

  void _close() {
    _searchQuery.addSafety("");
    searchController.closeAction?.call();
    searchController.textEditingController.clear();
  }

  @override
  void onDestroy() {
    _searchQuery.close();
    super.onDestroy();
  }
}

// ignore: must_be_immutable
class VToolbar extends VContainer implements PreferredSizeWidget {
  final String title;
  final Color titleColor;
  final TextStyle titleStyle;
  final Widget titleWidget;
  final String subtitle;
  final Color subtitleColor;
  final TextStyle subtitleStyle;
  final Widget subtitleWidget;
  final ScrollController scrollController;
  final EdgeInsetsGeometry padding;
  final Color background;
  final Color elevatedBackground;
  final double elevation;
  final Color elevationColor;
  final bool withSafeArea;
  PreferredSizeWidget bottomWidget;
  final List<VToolbarButton> actions;
  final List<VToolbarSubAction> subActions;

  VToolbar({
    this.title,
    this.titleColor,
    this.titleStyle,
    this.titleWidget,
    this.subtitle,
    this.subtitleColor,
    this.subtitleStyle,
    this.subtitleWidget,
    this.scrollController,
    this.padding,
    this.background,
    this.elevatedBackground = Colors.transparent,
    this.elevation = 0.0,
    this.elevationColor,
    this.withSafeArea = true,
    this.bottomWidget,
    this.actions,
    this.subActions,
  }) : preferredSize = Size.fromHeight(max(
            kToolbarHeight,
            (subtitle == null && subtitleWidget == null ? 54 : 76) +
                (bottomWidget?.preferredSize?.height ?? 0.0)));

  @override
  final Size preferredSize;

  final Setter<double> _elevation = Setter(0.0);
  final Setter<Color> _elevatedBackground = Setter();

  final double maxOffset = 10.0;

  double get maxElevation => min(elevation, 10.0);

  VoidCallback _scrollListener;

  @override
  void onCreate() {
    super.onCreate();
    _elevation.value = maxElevation;
    _elevatedBackground.value = elevatedBackground;

    if (scrollController != null) {
      _elevation.value = 0.0;
      _elevatedBackground.value = elevatedBackground?.withAlpha(0);

      if (_scrollListener != null) {
        scrollController.removeListener(_scrollListener);
      }

      final percentOffset = maxOffset / 100.0;
      final percentElevation = maxElevation / 100.0;

      _scrollListener = null;
      _scrollListener = () {
        final offset = min(scrollController.offset, maxOffset);
        final percent = offset / percentOffset;
        final currentElevation = percentElevation * percent;
        if (currentElevation != _elevation.value) {
          _elevation.value = currentElevation;
          if (percent == 0.0) {
            _elevatedBackground.value = elevatedBackground?.withAlpha(0);
          } else {
            _elevatedBackground.value =
                elevatedBackground?.withAlpha(min(max(((percent * 2) * 100).toInt(), 500), 1000));
          }
          reloadState();
        }
      };
      scrollController.addListener(_scrollListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget wTitle = titleWidget;
    if (wTitle == null && title?.isNotEmpty == true) {
      final titleColor = this.titleColor ?? ExampleColor.getColor().text.high_emphasis;
      wTitle = MyText(
        title,
        style: titleStyle ?? ExampleTheme.getTheme().textStyle.title_2(color: titleColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }

    if (wTitle != null) {
      wTitle = Padding(padding: const EdgeInsets.only(top: 8), child: wTitle);
    }

    Widget wSubtitle = subtitleWidget;
    if (wSubtitle == null && subtitle?.isNotEmpty == true) {
      final titleColor = subtitleColor ?? ExampleColor.getColor().text.high_emphasis;
      wSubtitle = MyText(
        subtitle,
        style: subtitleStyle ?? ExampleTheme.getTheme().textStyle.paragraph(color: titleColor),
        textOverflow: TextOverflow.ellipsis,
      );
    }

    List<Widget> wActions = actions
        ?.map((e) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: VButton.outline(
                width: 32,
                height: 32,
                iconPadding: EdgeInsets.zero,
                icon: e.icon,
                style: e.style ?? ExampleTheme.getTheme().button_outline.defaults,
                onTap: e.onTap,
              ),
            ))
        ?.toList();

    if (subActions?.isNotEmpty == true) {
      Widget wSubMenusAction = PopupMenuButton<int>(
        icon: MyIcon.icon(Icons.more_vert, color: AssertsColors.toolbar_icon_color),
        onSelected: (index) => subActions[index].onTap.call(),
        itemBuilder: (context) {
          List<PopupMenuItem<int>> popupList = [];
          for (int i = 0; i < subActions.length; i++) {
            final subItem = subActions[i];
            popupList.add(PopupMenuItem<int>(
                value: i,
                child: MyText(
                  subItem.text,
                  style: subItem.style ??
                      ExampleTheme.getTheme()
                          .textStyle
                          .paragraph(color: ExampleColor.getColor().text.high_emphasis),
                )));
          }
          return popupList;
        },
      );
      if (wActions == null) {
        wActions = [wSubMenusAction];
      } else {
        wActions.add(wSubMenusAction);
      }
    }

    Widget widget = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Column(
                  children: [wTitle, wSubtitle]..removeWhere((e) => e == null),
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            ...?wActions,
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        bottomWidget,
      ]..removeWhere((element) => element == null),
    );

    widget = super.buildPadding(widget, padding ?? const EdgeInsets.fromLTRB(12, 0, 8, 6));

    widget = SafeArea(child: widget);

    final backgroundColor = background ?? ExampleColor.getColor().background;
    final elevationColor = this.elevationColor ?? Colors.black26;

    widget = Container(
      child: widget,
      color: _elevatedBackground.value,
    );

    widget = super.buildBox(
      widget,
      null,
      null,
      backgroundColor,
      null,
      null,
      min(_elevation.value, maxElevation),
      elevationColor,
      const Offset(0, 1),
    );

    return widget;
  }
}

class VToolbarButton {
  factory VToolbarButton.light({
    @required IconData icon,
    VoidCallback onTap,
  }) {
    return VToolbarButton(
      icon: icon,
      style: ExampleTheme.getTheme().button_outline.defaultLight,
      onTap: onTap,
    );
  }

  factory VToolbarButton.dark({
    @required IconData icon,
    VoidCallback onTap,
  }) {
    return VToolbarButton(
      icon: icon,
      style: ExampleTheme.getTheme().button_outline.defaults,
      onTap: onTap,
    );
  }

  final IconData icon;
  final VoidCallback onTap;
  final AppButtonStyle style;

  VToolbarButton({@required this.icon, this.style, this.onTap});
}

class VToolbarSubAction {
  final String text;
  final VoidCallback onTap;
  final TextStyle style;

  VToolbarSubAction({@required this.text, this.style, this.onTap});
}

// ignore: must_be_immutable
class GLToolbar extends VContainer implements PreferredSizeWidget {
  final String title;
  final Color titleColor;
  final TextStyle titleStyle;
  final Widget titleWidget;
  final String subtitle;
  final Color subtitleColor;
  final TextStyle subtitleStyle;
  final Widget subtitleWidget;
  final ScrollController scrollController;
  final EdgeInsetsGeometry padding;
  final Color background;
  final Color elevatedBackground;
  final double elevation;
  final Color elevationColor;
  final bool withSafeArea;
  PreferredSizeWidget bottomWidget;
  final bool automaticallyImplyLeading;
  final Widget leading;
  final Color leadingColor;
  final VoidCallback onBackPressed;
  final List<GLToolbarButton> actions;
  final List<GLToolbarSubAction> subActions;
  final AppButtonStyle subActionStyle;
  final bool automaticallyAlignTitleInCenter;
  final SystemUiOverlayStyle brightness;

  GLToolbar({
    this.title,
    this.titleColor,
    this.titleStyle,
    this.titleWidget,
    this.automaticallyAlignTitleInCenter = false,
    this.subtitle,
    this.subtitleColor,
    this.subtitleStyle,
    this.subtitleWidget,
    this.scrollController,
    this.padding,
    this.background,
    this.brightness = SystemUiOverlayStyle.dark,
    this.elevatedBackground = Colors.transparent,
    this.elevation = 0.0,
    this.elevationColor,
    this.withSafeArea = true,
    this.bottomWidget,
    this.leading,
    this.leadingColor,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
    this.actions,
    this.subActions,
    this.subActionStyle,
  }) : preferredSize =
            Size.fromHeight(kToolbarHeight + (bottomWidget?.preferredSize?.height ?? 0.0) + 5);

  @override
  final Size preferredSize;

  final Setter<double> _elevation = Setter(0.0);
  final Setter<Color> _elevatedBackground = Setter();

  final double maxOffset = 10.0;

  double get maxElevation => min(elevation, 10.0);

  VoidCallback _scrollListener;

  @override
  void onCreate() {
    super.onCreate();
    _elevation.value = maxElevation;
    _elevatedBackground.value = elevatedBackground;

    if (scrollController != null) {
      _elevation.value = 0.0;
      _elevatedBackground.value = elevatedBackground?.withAlpha(0);

      if (_scrollListener != null) {
        scrollController.removeListener(_scrollListener);
      }

      final percentOffset = maxOffset / 100.0;
      final percentElevation = maxElevation / 100.0;

      _scrollListener = null;
      _scrollListener = () {
        final offset = min(scrollController.offset, maxOffset);
        final percent = offset / percentOffset;
        final currentElevation = percentElevation * percent;
        if (currentElevation != _elevation.value) {
          _elevation.value = currentElevation;
          if (percent == 0.0) {
            _elevatedBackground.value = elevatedBackground?.withAlpha(0);
          } else {
            _elevatedBackground.value =
                elevatedBackground?.withAlpha(min(max(((percent * 2) * 100).toInt(), 500), 1000));
          }
          reloadState();
        }
      };
      scrollController.addListener(_scrollListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget wLeading;
    if (automaticallyImplyLeading) {
      wLeading = GLButton(
        icon: Icons.keyboard_arrow_left,
        iconSize: 24,
        height: 40,
        width: 40,
        iconColor: (leadingColor ?? titleColor) ?? ExampleColor.getColor().text.regular_medium,
        onTap: () {
          if (onBackPressed != null) {
            onBackPressed.call();
          } else {
            Navigator.maybePop(context);
          }
        },
      );
    } else if (leading != null) {
      wLeading = leading;
    }

    if (wLeading != null) {
      wLeading =
          Container(margin: const EdgeInsets.only(left: 8, bottom: 8, top: 8), child: wLeading);
    }

    List<Widget> wActions = actions
        ?.map((e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GLButton(
                iconSize: 24,
                iconPadding: EdgeInsets.zero,
                icon: e.icon,
                iconColor: e.style?.iconColor ??
                    ExampleTheme.getTheme().button_outline.on_accent.iconColor,
                onTap: e.onTap,
              ),
            ))
        ?.toList();

    if (subActions?.isNotEmpty == true) {
      Widget wSubMenusAction = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: PopupMenuButton<int>(
          padding: EdgeInsets.zero,
          icon: MyIcon.icon(Icons.more_vert,
              color: subActionStyle?.iconColor ??
                  ExampleTheme.getTheme().button_outline.on_accent.iconColor),
          onSelected: (index) => subActions[index].onTap.call(),
          itemBuilder: (context) {
            List<PopupMenuItem<int>> popupList = [];
            for (int i = 0; i < subActions.length; i++) {
              final subItem = subActions[i];
              popupList.add(PopupMenuItem<int>(
                  value: i,
                  child: MyText(
                    subItem.text,
                    style: subItem.style ??
                        ExampleTheme.getTheme()
                            .textStyle
                            .paragraph(color: ExampleColor.getColor().text.high_emphasis),
                  )));
            }
            return popupList;
          },
        ),
      );
      if (wActions == null) {
        wActions = [wSubMenusAction];
      } else {
        wActions.add(wSubMenusAction);
      }
    }

    Alignment alignment;

    if (automaticallyAlignTitleInCenter) {
      alignment = Alignment.center;
    }

    EdgeInsets textPadding = EdgeInsets.zero;

    if (!automaticallyAlignTitleInCenter) {
      textPadding = const EdgeInsets.only(left: 16);
    }

    if (wLeading != null) {
      textPadding = const EdgeInsets.only(left: 8);
    }

    if (wLeading != null && automaticallyAlignTitleInCenter) {
      textPadding = const EdgeInsets.only(right: 48);
    }

    Widget wTitle = titleWidget;
    if (wTitle == null && title?.isNotEmpty == true) {
      final titleColor = this.titleColor ?? ExampleColor.getColor().text.on_accent_high;

      wTitle = MyText(
        title,
        style: titleStyle ?? ExampleTheme.getTheme().textStyle.h4(color: titleColor),
        padding: textPadding,
        alignment: alignment,
        textOverflow: TextOverflow.ellipsis,
      );
    }

    Widget wSubtitle = subtitleWidget;
    if (wSubtitle != null) {
      wSubtitle = Padding(padding: textPadding, child: wSubtitle);
    }
    if (wSubtitle == null && subtitle?.isNotEmpty == true) {
      final titleColor = subtitleColor ?? ExampleColor.getColor().text.on_accent_high;
      wSubtitle = MyText(
        subtitle,
        padding: textPadding,
        style: subtitleStyle ?? ExampleTheme.getTheme().textStyle.caption(color: titleColor),
        alignment: alignment,
        textOverflow: TextOverflow.ellipsis,
      );
    }

    Widget widget = Row(
      children: [
        if (wLeading != null) wLeading,
        Expanded(
          child: Column(
            children: [wTitle, wSubtitle]..removeWhere((e) => e == null),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        ...?wActions,
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    if (bottomWidget != null) {
      widget = Column(
        children: [widget, bottomWidget].where((e) => e != null).toList(),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    }

    final backgroundColor = background ?? ExampleColor.getColor().accent;
    final elevationColor = this.elevationColor;

    widget = Container(
      child: widget,
      color: _elevatedBackground.value,
    );
    widget = SafeArea(child: widget, bottom: false);

    widget = super.buildBox(
      widget,
      null,
      null,
      backgroundColor,
      null,
      null,
      min(_elevation.value, maxElevation),
      elevationColor,
      const Offset(0, 1),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: widget,
      value: brightness ?? SystemUiOverlayStyle.dark,
    );
  }
}

class GLToolbarButton {
  factory GLToolbarButton.light({
    @required IconData icon,
    VoidCallback onTap,
  }) {
    return GLToolbarButton(
      icon: icon,
      style: ExampleTheme.getTheme().button_outline.defaultLight,
      onTap: onTap,
    );
  }

  factory GLToolbarButton.dark({
    @required IconData icon,
    VoidCallback onTap,
  }) {
    return GLToolbarButton(
      icon: icon,
      style: ExampleTheme.getTheme().button_outline.defaults,
      onTap: onTap,
    );
  }

  final IconData icon;
  final VoidCallback onTap;
  final AppButtonStyle style;

  GLToolbarButton({@required this.icon, this.style, this.onTap});
}

class GLToolbarSearch extends VContainer implements PreferredSizeWidget {
  final Size preferredSize;

  final BuildContext context;

  final SearchController searchController;
  final PreferredSizeWidget bottomWidget;
  final Color backgroundColor;

  BehaviorSubject<String> _searchQuery;

  GLToolbarSearch({
    @required this.context,
    @required this.searchController,
    this.backgroundColor,
    this.bottomWidget,
  }) : preferredSize = Size.fromHeight(
            56 + MediaQuery.of(context).padding.top + (bottomWidget?.preferredSize?.height ?? 0.0));

  @override
  void onCreate() {
    super.onCreate();

    _searchQuery = BehaviorSubject.seeded(searchController.textEditingController?.text ?? "");

    _searchQuery.debounceTime(const Duration(milliseconds: 500)).listen(searchController.onChange);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget widget = GLEditText(
      leftWidget: GLButton.regular(
        icon: Icons.close,
        style: ExampleTheme.getTheme().button_normal.regular,
        onTap: _close,
        width: 35,
        height: 35,
      ),
      textController: searchController.textEditingController,
      style: ExampleTheme.getTheme().edittext.regular,
      textStyle: ExampleTheme.getTheme()
          .textStyle
          .body1(color: ExampleColor.getColor().text.regular_medium),
      onChanged: _onChange,
      hintText: searchController.hintText,
      margin: EdgeInsets.only(left: 8, right: 12, top: 5, bottom: 8),
      inputFieldHeight: 45,
      focusNode: searchController.searchFocusNode,
      rightIconButton: searchController.rightIcon,
      onRightTap: searchController.onRightTap,
      autofocus: true,
    );

    widget = SafeArea(child: widget, bottom: false);

    if (bottomWidget != null) {
      widget = Column(
        children: [widget, bottomWidget].where((e) => e != null).toList(),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    }

    return super.buildBox(
      widget,
      null,
      null,
      backgroundColor ?? ExampleColor.getColor().background,
      null,
      null,
      null,
      null,
      Offset.zero,
    );
  }

  void _onChange(String text) {
    _searchQuery.addSafety(text);
  }

  void _close() {
    _searchQuery.addSafety("");
    searchController.closeAction?.call();
    searchController.textEditingController.clear();
  }

  @override
  void onDestroy() {
    _searchQuery.close();
    super.onDestroy();
  }
}

class GLToolbarSubAction {
  final String text;
  final VoidCallback onTap;
  final TextStyle style;

  GLToolbarSubAction({@required this.text, this.style, this.onTap});
}
