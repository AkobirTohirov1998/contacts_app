import 'package:first_app/resources/theme.dart';
import 'package:first_app/widgets/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

typedef OnCreateTabController = void Function(TabController controller);

typedef OnTabIndexSelected = void Function(int index);

class GLTabController extends VContainer implements PreferredSizeWidget {
  static const double TAB_CONTROLLER_HEIGHT = 48;

  @override
  final Size preferredSize;

  OnCreateTabController onCreateTabController;
  OnTabIndexSelected onTabIndexSelected;
  TabController _tabController;
  TextStyle tabTextStyle;
  TextStyle selectedTabTexStyle;
  AppTabControllerStyle style;

  ScrollController _scrollController;

  int initialIndex;
  bool isScrollable;

  List<GLTab> items;

  LazyStream _start = LazyStream(() => false);
  LazyStream _end = LazyStream(() => true);

  GLTabController({
    @required List<GLTab> items,
    AppTabControllerStyle style,
    TextStyle tabTextStyle,
    TextStyle selectedTabTexStyle,
    ScrollController scrollController,
    TabController tabController,
    this.initialIndex,
    this.isScrollable,
    this.onCreateTabController,
    this.onTabIndexSelected,
  })  : assert(items?.isNotEmpty == true),
        this.preferredSize = Size.fromHeight(TAB_CONTROLLER_HEIGHT),
        this.style = style ?? ExampleTheme.getTheme().tabController.regular,
        this.items = items,
        this.tabTextStyle = tabTextStyle,
        this.selectedTabTexStyle = selectedTabTexStyle ?? tabTextStyle,
        this._scrollController = scrollController ?? ScrollController(keepScrollOffset: true),
        this._tabController = tabController;

  void onCreate() {
    super.onCreate();
    _scrollController.addListener(_scrollListener);
    onTabIndexSelected?.call(initialIndex ?? 0);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget widget = DefaultTabController(
      length: items.length,
      child: Builder(
        builder: (co) {
          if (_tabController == null) {
            _tabController = DefaultTabController.of(context);
            onCreateTabController?.call(_tabController);
          }
          return TabBar(
            isScrollable: isScrollable == true,
            controller: _tabController,
            tabs: items,
            onTap: onTabIndexSelected,
            unselectedLabelStyle:
                tabTextStyle ?? ExampleTheme.getTheme().textStyle.bodyBold(color: style.textColor),
            unselectedLabelColor: style.textColor,
            labelStyle: selectedTabTexStyle ??
                ExampleTheme.getTheme().textStyle.bodyBold(color: style.selectedTextColor),
            labelColor: style.selectedTextColor,
            indicator: BoxDecoration(color: style.tabColor),
            indicatorColor: style.selectedTabColor,
          );
        },
      ),
      initialIndex: initialIndex ?? 0,
    );

    if (this.isScrollable == true) {
      widget = SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: widget,
      );
      Widget wLeftIndicator = StreamBuilder(
          stream: _end.stream,
          builder: (context, snapshot) {
            return snapshot.data == true
                ? Container(alignment: Alignment.centerLeft)
                : Container(
                    child: MyIcon(
                      icon: Icons.arrow_right,
                      color: style.tabColor,
                      alignment: Alignment.centerRight,
                    ),
                    height: preferredSize.height,
                  );
          });
      Widget wRightIndicator = StreamBuilder(
        stream: _start.stream,
        builder: (context, snapshot) {
          return snapshot.data == true
              ? Container(alignment: Alignment.centerRight)
              : Container(
                  child: MyIcon(
                    icon: Icons.arrow_left,
                    alignment: Alignment.centerLeft,
                    color: style.tabColor,
                  ),
                  height: preferredSize.height,
                );
        },
      );

      widget = Stack(children: [widget, wRightIndicator, wLeftIndicator]);
    }

    return Container(child: widget, width: double.maxFinite);
  }

  void _scrollListener() {
    /// notify when [GLTabController] reached its last element
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 20) {
      if (!_end.value) {
        _end.add(true);
      }
    } else {
      _end.add(false);
    }

    /// notify when [GLTabController] reached its start element
    if (_scrollController.offset <= (_scrollController.position.minScrollExtent + 20)) {
      if (!_start.value) {
        _start.add(true);
      }
    } else {
      _start.add(false);
    }
  }

  @override
  void onDestroy() {
    _start.close();
    _end.close();
    _scrollController.dispose();
    super.onDestroy();
  }
}

class GLTab extends VContainer implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final IconData icon;
  final Axis contentDirection;

  GLTab({String title, IconData icon, this.contentDirection = Axis.horizontal})
      : assert(title?.isNotEmpty == true || icon != null,
            "GLTab title?.isNotEmpty == true || icon != null"),
        this.preferredSize = Size.fromHeight(GLTabController.TAB_CONTROLLER_HEIGHT),
        this.title = title,
        this.icon = icon;

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget wIcon;
    if (icon != null) {
      wIcon = Container(child: MyIcon.icon(icon, size: 16), height: 20);
    }

    Widget wTitle;

    if (title?.isNotEmpty == true) {
      wTitle = MyText(title, textOverflow: TextOverflow.clip, alignment: Alignment.center);
    }

    Widget wPadding;
    if (wIcon != null && wTitle != null) {
      wPadding = SizedBox(width: 10);
    }
    Widget widget = Row(
      children: [wIcon, wPadding, wTitle].where((e) => e != null).toList(),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
    if (contentDirection == Axis.vertical) {
      widget = Column(
        children: [wIcon, wPadding, wTitle].where((e) => e != null).toList(),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    }

    widget = Container(child: widget, alignment: Alignment.center, height: preferredSize.height);

    return buildBox(
      widget,
      null,
      preferredSize.height,
      null,
      null,
      null,
      null,
      null,
    );
  }
}
