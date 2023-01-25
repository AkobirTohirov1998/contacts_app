import 'dart:async' as async;

import 'package:first_app/bloc/bloc_provider.dart';
import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/common/resources.dart';
import 'package:first_app/gwslib/mold_content_fragment.dart';
import 'package:first_app/resources/colors.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/screen/view.dart';
import 'package:first_app/widgets/message_screen.dart';
import 'package:first_app/widgets/progress_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:provider/provider.dart';

abstract class MyScreen<B extends MyBloc, V extends View> extends Screen
    with WidgetsBindingObserver
    implements View {
  MyScreenNotifier _notifier = new MyScreenNotifier();

  ExampleAppTheme get theme => ExampleTheme.getTheme();

  AppTextStyle get textStyle => theme.textStyle;

  ExampleAppColor get exampleColors => ExampleColor.getColor();

  MyScreenNotifier get notifier => _notifier;

  B _bloc;

  B get bloc => _bloc;

  MyBloc get myBloc => _bloc;

  void setBackgroundColor(Color color) {
    _notifier.backgroundColor = color;
  }

  void setSearchEnable() {
    _notifier.setSearchEnabled = !_notifier.isSearchEnabled;
  }

  bool get isSearchEnabled => _notifier.isSearchEnabled;

  Color getBackgroundColor() {
    return _notifier._backgroundColor;
  }

  void setFragmentScrollable(bool scrollable) {
    _notifier.scrollable = scrollable;
  }

  void setFloatActionButton(Widget floatActionButton) {
    _notifier.floatActionButton = floatActionButton;
  }

  @override
  void onCreate() {
    super.onCreate();
    WidgetsBinding.instance.addObserver(this);
    if (_bloc == null) {
      _bloc = screenArgument?.getObject<B>("_myscreen_block_${B.toString()}");
      if (_bloc == null) {
        _bloc = BlocProvider.of(this).get(V);
        _bloc.onCreate();
        screenArgument?.putObject("_myscreen_block_${B.toString()}", _bloc);
      }
    }
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return ChangeNotifierProvider<MyScreenNotifier>.value(
      value: _notifier,
      child: Consumer<MyScreenNotifier>(builder: (_, model, child) {
        final ctx = getContext();
        final notifier = model;

        Widget bodyWidget = onBuildBodyWidget(ctx);

        if (notifier._scrollable) {
          bodyWidget = Expanded(
            child: SingleChildScrollView(child: bodyWidget),
          );
        } else {
          bodyWidget = Expanded(child: bodyWidget, flex: 1);
        }

        return Stack(
          children: [
            Scaffold(
              backgroundColor: notifier._backgroundColor,
              floatingActionButton: notifier._floatActionButton,
              appBar: notifier.isSearchEnabled
                  ? onBuildAppBarSearchWidget(context)
                  : onBuildAppBarWidget(context),
              bottomNavigationBar: onBuildBottomNavigationBar(getContext()),
              body: SafeArea(
                  top: false,
                  child: MyTable.vertical([
                    MessageScreenWidget(
                      myBloc.getMessageStream(),
                      onCloseTap: () => myBloc.resetMessage(),
                    ),
                    bodyWidget,
                  ])),
            ),
            ProgressScreenWidget(myBloc.getProgressStream())
          ],
        );
      }),
    );
  }

  PreferredSizeWidget onBuildAppBarWidget(BuildContext context) {
    return null;
  }

  Widget onBuildBottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget onBuildBodyWidget(BuildContext context) {
    return null;
  }

  PreferredSizeWidget onBuildAppBarSearchWidget(BuildContext context) {
    return null;
  }

  Widget buildBottomToolbar({
    bool automaticallyImplyLeading = true,
    ActionMenuItem leading,
    BottomSearchMenuItem searchMenu,
    List<ActionMenuItem> menus,
    Color background,
  }) {
    return BottomMenuWidget(
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        menus: menus,
        searchMenu: searchMenu,
        background: background,
        height: 70,
        width: double.infinity);
  }

  MyAppBar buildLargeTitleToolbar(
      {@required String title,
      bool centerTitle = false,
      TextStyle textStyle,
      Color toolbarColor,
      bool automaticallyImplyLeading = false,
      List<ActionMenuItem> actions}) {
    return MyAppBar(
      brightness: Brightness.light,
      title: MyText(title, style: textStyle ?? this.textStyle.title_2()),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions?.map((e) => e.toMenuItem())?.toList() ?? [],
      centerTitle: centerTitle,
      elevation: 0,
      backgroundColor: toolbarColor ?? ExampleColor.getColor().block.background,
    );
  }

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
        icon: MyIcon.icon(
          Icons.arrow_back_rounded,
          color: exampleColors.text.medium_emphasis,
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
        style: textStyle.title_4(color: AssertsColors.toolbar_icon_color),
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
    return MyAppBar(
      leading: leadingWidget,
      title: titleWidget,
      actions: toolbarActions,
      elevation: 0,
      backgroundColor: background ?? AssertsColors.toolbar_color,
    );
  }

  @override
  void onDestroy() {
    _bloc?.onDestroy();
    WidgetsBinding.instance.removeObserver(this);
    super.onDestroy();
  }
}

class MyScreenNotifier extends ChangeNotifier {
  void reload() {
    notifyListeners();
  }

  @nonVirtual
  Widget get getFloatActionButton => _floatActionButton;

  @nonVirtual
  bool get isScrollable => _scrollable;

  @nonVirtual
  bool get isSearchEnabled => _isSearchEnabled;

  @nonVirtual
  Color get getBackgroundColor => _backgroundColor;

  Color _backgroundColor;

  set backgroundColor(Color newValue) {
    _backgroundColor = newValue;
    notifyListeners();
  }

  bool _isSearchEnabled = false;

  set setSearchEnabled(bool newValue) {
    _isSearchEnabled = newValue;
    notifyListeners();
  }

  bool _scrollable = true;

  set scrollable(bool newValue) {
    _scrollable = newValue;
    notifyListeners();
  }

  Widget _floatActionButton;

  set floatActionButton(Widget newValue) {
    _floatActionButton = newValue;
    notifyListeners();
  }
}

abstract class MyComponent<B extends MyBloc, V extends View> extends Component implements View {
  B _bloc;

  B get bloc => _bloc;

  MyBloc get myBloc => _bloc;

  @override
  void onCreate() {
    super.onCreate();
    _bloc = BlocProvider.of(this).get(V);
    _bloc.onCreate();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget bodyWidget = onBuildBodyWidget(getContext());
    bodyWidget = Expanded(child: bodyWidget, flex: 1);

    return Stack(
      children: [
        Scaffold(
          appBar: onBuildAppBarWidget(getContext()),
          body: MyTable.vertical([
            MessageScreenWidget(
              myBloc.getMessageStream(),
              onCloseTap: () => myBloc.resetMessage(),
            ),
            bodyWidget,
          ]),
        ),
        ProgressScreenWidget(myBloc.getProgressStream())
      ],
    );
  }

  PreferredSizeWidget onBuildAppBarWidget(BuildContext context) {
    return null;
  }

  Widget onBuildBodyWidget(BuildContext context) {
    return null;
  }

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
        style: ExampleTheme.getTheme().textStyle.title_4(color: AssertsColors.toolbar_icon_color),
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
    return MyAppBar(
      leading: leadingWidget,
      title: titleWidget,
      actions: toolbarActions,
      elevation: 0,
      backgroundColor: background ?? AssertsColors.toolbar_color,
    );
  }

  Widget buildSearchToolbar(
          {dynamic leading,
          dynamic title,
          String subTitle,
          List<MenuItem> menus,
          SearchMenuItem searchMenu,
          Color background}) =>
      _PreferredSizeSearchAppBar(leading, title, subTitle, menus, searchMenu, background);

  Widget buildSearchToolbarWidget(
          {dynamic leading,
          dynamic title,
          String subTitle,
          List<MenuItem> menus,
          SearchMenuItem searchMenu,
          Color background}) =>
      _SearchAppBar(leading, title, subTitle, menus, searchMenu, background);

  @override
  void onDestroy() {
    _bloc?.onDestroy();
    super.onDestroy();
  }
}

class ActionMenuItem {
  static const int CUSTOM = 1;
  static const int CLOSE = 2;
  static const int BACK_BUTTON = 3;

  final int type;
  final IconData icon;
  final String text;
  Color tintColor; //  icon and text color
  Color backgroundColor;
  final VoidCallback callback;
  final int flex;

  ActionMenuItem({
    this.type = CUSTOM,
    this.icon,
    this.text,
    this.backgroundColor,
    this.tintColor,
    this.flex = 1,
    this.callback,
  }) {
    tintColor = tintColor ?? ExampleColor.getColor().text.medium_emphasis;
    backgroundColor = backgroundColor ?? ExampleColor.getColor().block.surface;
  }

  factory ActionMenuItem.cancel({String text, int flex = 1, VoidCallback callback}) {
    return ActionMenuItem(
        type: CLOSE,
        text: text,
        tintColor: ExampleColor.getColor().block.surface,
        backgroundColor: ExampleColor.getColor().status.error,
        icon: Icons.close,
        flex: flex,
        callback: callback);
  }

  factory ActionMenuItem.empty({int flex = 1}) {
    return ActionMenuItem(
        type: CUSTOM,
        backgroundColor: ExampleColor.getColor().block.surface,
        flex: flex,
        callback: () {});
  }

  factory ActionMenuItem.backButton({String text, int flex = 1, VoidCallback callback}) {
    return ActionMenuItem(
        type: BACK_BUTTON,
        text: text,
        tintColor: ExampleColor.getColor().text.medium_emphasis,
        backgroundColor: ExampleColor.getColor().block.surface,
        icon: Icons.arrow_back,
        flex: flex,
        callback: callback);
  }

  Widget toMenuItem() {
    final iconWidget = MyIcon.icon(
      icon,
      size: 18,
      color: ExampleColor.getColor().text.medium_emphasis,
      padding: const EdgeInsets.all(1),
    );
    return SizedBox(
      width: 45,
      height: 30,
      child: MyTable.vertical(
        [iconWidget],
        onTapCallback: callback,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        margin: const EdgeInsets.only(bottom: 14, top: 14, left: 6, right: 11),
        borderColor: ExampleColor.getColor().text.medium_emphasis,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class BottomSearchMenuItem extends ActionMenuItem {
  final String query;
  final OnQueryCallback _onQueryCallback;
  final OnTextChangeCallback _onTextChangeCallback;
  final Duration textChangeDuration;

  BottomSearchMenuItem({
    this.query,
    OnQueryCallback onQueryCallback,
    OnTextChangeCallback onTextChangeCallback,
    this.textChangeDuration = const Duration(milliseconds: 500),
    IconData icon,
    String text,
    Color tintColor, //  icon and text color
    Color backgroundColor,
    VoidCallback onSearchClickAction,
    int flex,
  })  : _onTextChangeCallback = onTextChangeCallback,
        _onQueryCallback = onQueryCallback,
        super(
          type: ActionMenuItem.CUSTOM,
          icon: icon ?? Icons.search,
          text: text ?? ("account:bottom_menu_widget:search").translate(),
          tintColor: tintColor ?? ExampleColor.getColor().text.medium_emphasis,
          backgroundColor: backgroundColor ?? ExampleColor.getColor().block.surface,
          callback: onSearchClickAction,
          flex: flex ?? 1,
        );

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

class BottomMenuWidget extends MoldStatefulWidget {
  static String t(String key) => "account:bottom_menu_widget:$key".translate();

  final double height;
  final double width;
  final Color background;
  final bool automaticallyImplyLeading;

  final BottomSearchMenuItem searchMenu;
  ActionMenuItem leading;
  List<ActionMenuItem> menus;

  final LazyStream<_SearchMenuState> _searchMenuState = LazyStream(() => _SearchMenuState.CLOSED);
  String query;

  BottomMenuWidget({
    this.leading,
    this.menus,
    this.background,
    this.automaticallyImplyLeading,
    this.height,
    this.width,
    this.searchMenu,
  }) {
    searchMenu?.query?.let((it) => query = it);
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    Widget leadingWidget;
    Widget searchWidget;

    if (leading == null && automaticallyImplyLeading && Navigator.canPop(getContext())) {
      final backButton = ActionMenuItem.backButton(
        text: t("back_button"),
        callback: () {
          Mold.onContextBackPressed(getContext());
        },
      );
      leadingWidget = _buildMenuItemWidget(backButton);
    } else if (leading != null) {
      leadingWidget = _buildMenuItemWidget(leading);
    }

    if (searchMenu != null) {
      searchWidget = _buildMenuItemWidget(ActionMenuItem(
          type: searchMenu.type,
          icon: searchMenu.icon,
          text: searchMenu.text,
          flex: searchMenu.flex,
          tintColor: searchMenu.tintColor,
          backgroundColor: searchMenu.backgroundColor,
          callback: () {
            searchMenu.callback?.call();
            changeSearchState();
          }));
    }

    Widget actionsWidget = Container();

    if (menus?.isNotEmpty == true) {
      List<Widget> menuActionWidgets = menus.map((e) => _buildMenuItemWidget(e)).toList();

      actionsWidget = Expanded(
        child: MyTable.horizontal(
          menuActionWidgets,
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        flex: 2,
      );
    }
    final safeAreaBootmInset = MediaQuery.of(context).padding.bottom;
    final safeArea = safeAreaBootmInset > 0 ? safeAreaBootmInset - 10 : 0.0;
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: width,
        height: height + safeArea,
        child: StreamBuilder<_SearchMenuState>(
            stream: _searchMenuState.stream,
            builder: (_, snapshot) {
              if (snapshot.data == _SearchMenuState.OPENED) {
                return _buildMenuSearchWidget(searchMenu);
              }

              List<Widget> widgets = [actionsWidget];

              if (leadingWidget != null) {
                widgets.insert(0, leadingWidget);
              }

              if (searchWidget != null) {
                widgets.add(searchWidget);
              }
              return MyTable.horizontal(
                widgets,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                background: background ?? ExampleColor.getColor().block.surface,
                margin: EdgeInsets.only(bottom: safeArea),
                elevation: 3,
              );
            }),
        color: background ?? ExampleColor.getColor().contrast,
      ),
    );
  }

  Widget _buildMenuItemWidget(ActionMenuItem item) {
    return MyTable.vertical(
      [
        if (item.icon != null)
          MyIcon.icon(
            item.icon,
            color: item.tintColor,
            size: 20,
          ),
        if (item.text != null)
          MyText(
            item.text,
            style: ExampleTheme.getTheme().textStyle.caption(color: item.tintColor),
            textAlign: TextAlign.center,
            padding: const EdgeInsets.only(top: 4),
          ),
      ],
      background: item.backgroundColor,
      flex: item.flex > 1 ? item.flex : null,
      width: 72,
      height: height,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      onTapCallback: item.callback,
    );
  }

  Widget _buildMenuSearchWidget(BottomSearchMenuItem item) {
    return MyTable.vertical(
      [
        TextFormField(
          style: ExampleTheme.getTheme()
              .textStyle
              .title_5(color: ExampleColor.getColor().text.high_emphasis),
          textAlignVertical: TextAlignVertical.center,
          controller: TextEditingController(text: query ?? ""),
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: (newText) {
            item.queryChanged(newText);
            query = newText;
          },
          onFieldSubmitted: (newText) {
            item.notifyText(newText);
            query = newText;
          },
          decoration: InputDecoration(
            filled: true,
            hintText: t("search_hint"),
            fillColor: ExampleColor.getColor().block.surface_2,
            suffixIcon: _buildSearchCancelBtnWidget(),
            hintStyle: ExampleTheme.getTheme()
                .textStyle
                .title_5(color: ExampleColor.getColor().text.medium_emphasis),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ExampleColor.getColor().accent),
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ExampleColor.getColor().border.low_emphasis),
              borderRadius: BorderRadius.zero,
            ),
            border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: MyIcon.icon(
              Icons.search,
              color: ExampleColor.getColor().text.medium_emphasis,
              size: 20,
            ),
          ),
        )
      ],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      background: item.backgroundColor,
      height: height,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _buildSearchCancelBtnWidget() {
    return InkWell(
        child: Container(
          width: 32,
          height: 32,
          child: Center(
            child: MyIcon.icon(Icons.close,
                color: ExampleColor.getColor().text.on_primary_high_emphasis, size: 20),
          ),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: ExampleColor.getColor().contrast),
          margin: const EdgeInsets.all(4),
        ),
        onTap: changeSearchState);
  }

  void changeSearchState() {
    if (_searchMenuState.value == _SearchMenuState.CLOSED) {
      _searchMenuState.add(_SearchMenuState.OPENED);
    } else {
      _searchMenuState.add(_SearchMenuState.CLOSED);
      searchMenu.notifyText("");
      query = "";
    }
  }

  @override
  void onDestroy() {
    _searchMenuState.close();
    super.onDestroy();
  }
}

typedef OnQueryCallback = void Function(String);
typedef OnTextChangeCallback = void Function(String);

enum _SearchMenuState { OPENED, CLOSED }

class _PreferredSizeSearchAppBar extends _SearchAppBar implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final LazyStream<_SearchMenuState> _searchMenuState = LazyStream(() => _SearchMenuState.CLOSED);
  String _query;

  _PreferredSizeSearchAppBar(
    dynamic leading,
    dynamic title,
    String subTitle,
    List<MenuItem> menus,
    SearchMenuItem searchMenu,
    Color background,
  )   : preferredSize = Size.fromHeight(kToolbarHeight),
        super(
          leading,
          title,
          subTitle,
          menus,
          searchMenu,
          background,
        );
}

class _SearchAppBar extends MoldStatefulWidget {
  final dynamic leading;
  final dynamic title;
  final String subTitle;
  final List<MenuItem> menus;
  final SearchMenuItem searchMenu;
  final Color background;

  final LazyStream<_SearchMenuState> _searchMenuState = LazyStream(() => _SearchMenuState.CLOSED);
  String _query;

  _SearchAppBar(
    this.leading,
    this.title,
    this.subTitle,
    this.menus,
    this.searchMenu,
    this.background,
  );

  @override
  Widget onCreateWidget(BuildContext context) {
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
        style: ExampleTheme.getTheme().textStyle.title_4(color: AssertsColors.toolbar_icon_color),
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

    if (searchMenu != null) {
      toolbarActions.add(searchMenu.toSearchWidget(() {
        searchMenu.callback?.call();
        changeSearchState();
      }));
    }
    return StreamBuilder<_SearchMenuState>(
        stream: _searchMenuState.stream,
        builder: (_, snapshot) {
          if (snapshot.data == _SearchMenuState.OPENED) {
            return _buildMenuSearchWidget();
          }

          return MyAppBar(
            leading: leadingWidget,
            title: titleWidget,
            actions: toolbarActions,
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: background ?? AssertsColors.toolbar_color,
          );
        });
  }

  Widget _buildMenuSearchWidget() {
    return MyTable.horizontal(
      [
        IconButton(
            icon: MyIcon.svg(AssertsSvg.leading_back, color: AssertsColors.toolbar_icon_color),
            onPressed: () => changeSearchState()),
        Expanded(
            child: SizedBox(
          height: 50,
          child: TextFormField(
            style: ExampleTheme.getTheme()
                .textStyle
                .title_5(color: ExampleColor.getColor().text.high_emphasis),
            textAlignVertical: TextAlignVertical.center,
            autofocus: true,
            controller: TextEditingController(text: this._query ?? ""),
            textInputAction: TextInputAction.search,
            onChanged: (newText) {
              print("onChanged($newText)");
              searchMenu.queryChanged(newText);

              _query = newText;
            },
            onFieldSubmitted: (newText) {
              print("onFieldSubmitted(${newText})");
              searchMenu.notifyText(newText);
              _query = newText;
            },
            decoration: InputDecoration(
              filled: true,
              hintText: "account:mold_content_fragment:search_hint".translate(),
              fillColor: ExampleColor.getColor().block.surface_2,
              hintStyle: ExampleTheme.getTheme()
                  .textStyle
                  .title_5(color: ExampleColor.getColor().text.medium_emphasis),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ExampleColor.getColor().accent),
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ExampleColor.getColor().border.low_emphasis),
                borderRadius: BorderRadius.zero,
              ),
              border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        )),
        IconButton(
            icon: MyIcon.icon(Icons.clear, color: AssertsColors.toolbar_icon_color),
            onPressed: () {
              searchMenu.notifyText("");
              _query = "";
            }),
      ],
      padding: const EdgeInsets.symmetric(horizontal: 4),
      background: AssertsColors.toolbar_color,
      height: 100,
      width: double.infinity,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  void changeSearchState() {
    print("changeSearchState()");
    if (_searchMenuState.value == _SearchMenuState.CLOSED) {
      _searchMenuState.add(_SearchMenuState.OPENED);
    } else {
      _searchMenuState.add(_SearchMenuState.CLOSED);
      searchMenu?.notifyText("");
      _query = "";
    }
  }

  @override
  void onDestroy() {
    _searchMenuState.close();
    super.onDestroy();
  }
}
