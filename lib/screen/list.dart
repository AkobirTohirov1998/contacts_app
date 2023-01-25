import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:rxdart/rxdart.dart';

import '../gwslib/collection/interfaces.dart';

abstract class MyListScreen<B extends MyBloc, V extends View, E> extends MyScreen<B, V>
    implements View {
  final FilterList<E> _filterList = FilterList();

  IconData _emptyIcon;
  String _emptyString;
  Widget _emptyWidget;
  ScrollController _controller;

  Future<void> Function() _onPullRefresh;

  ScrollController get scrollController => _controller;

  bool _onTheTop = true;

  bool _onBottom = true;

  EdgeInsets _padding = const EdgeInsets.only(bottom: 40);

  EdgeInsets get bottomDefaultPadding => _padding;

  @override
  void onCreate() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.onCreate();

    setFragmentScrollable(false);
  }

  void setPadding(EdgeInsets insets) {
    _padding = insets;
  }

  void setItems(List<E> items) {
    _filterList.filter(items);
  }

  List<E> getItems() {
    return _filterList?.filterItems?.value ?? [];
  }

  int getSize() {
    return _filterList._items.length;
  }

  void setEmptyIcon(IconData icon) {
    _emptyIcon = icon;
  }

  void setEmptyString(String message) {
    _emptyString = message;
  }

  void setOnPullRefresh(Future<void> Function() onPullRefresh) {
    _onPullRefresh = onPullRefresh;
  }

  /// notify when [ListView] reached its last element
  void didEndList() {
    print("didEndList");
  }

  /// notify when [ListView] reached its top
  void didReachedTop() {
    print("didReachedTop");
  }

  /// listen scroll delegate
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 60) {
      if (!_onBottom) {
        _onBottom = true;
        didEndList();
      }
    } else {
      _onBottom = false;
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      if (!_onTheTop) {
        _onTheTop = true;
        didReachedTop();
      }
    } else {
      _onTheTop = false;
    }
  }

  void setEmptyWidget(Widget widget) {
    _emptyWidget = widget;
  }

  Widget adapterPrePopulateWidget(BuildContext context, E item, int currentIndex) {
    return null;
  }

  Widget adapterPopulateWidget(BuildContext context, E element);

  Widget _emptyContent(BuildContext context) {
    if (_emptyWidget != null) {
      if (_onPullRefresh != null) {
        return RefreshIndicator(
          child: Stack(children: [ListView(), _emptyWidget]),
          onRefresh: _onPullRefresh,
        );
      }
      return _emptyWidget;
    }

    if (_emptyIcon == null && _emptyString == null) {
      return Container();
    }

    Widget emptyWidget = Align(
      alignment: Alignment.center,
      child: Padding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(_emptyIcon, size: 150, color: Colors.black12),
            Padding(
              child: Text(_emptyString ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54, fontSize: 22)),
              padding: const EdgeInsets.all(24),
            ),
          ],
        ),
        padding: const EdgeInsets.only(bottom: 36),
      ),
    );

    if (_onPullRefresh != null) {
      return RefreshIndicator(
        child: Stack(children: <Widget>[ListView(), emptyWidget]),
        onRefresh: _onPullRefresh,
      );
    }
    return Stack(children: <Widget>[emptyWidget]);
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    final header = headerView();
    return StreamBuilder(
      initialData: null,
      stream: _filterList.getFilterItemsSubject(),
      builder: (_, snapshot) {
        if (snapshot.data == null || (snapshot.data as Iterable<E>).isEmpty) {
          return MyTable.vertical([
            header,
            Expanded(child: _emptyContent(context)),
          ]);
        }

        List<E> list = snapshot.data;
        final listSize = list.length;

        Widget listBuilderWidget = ListView.builder(
          controller: _controller,
          itemBuilder: (buildContext, index) {
            if (index > 0 && index >= listSize) {
              return const SizedBox(height: 40);
            }
            final item = list[index];
            final itemWidget = adapterPrePopulateWidget(buildContext, item, index);
            if (itemWidget != null) {
              return itemWidget;
            }
            return adapterPopulateWidget(buildContext, item);
          },
          itemCount: listSize == 0 ? listSize : listSize + 1,
          padding: _padding,
          physics: const AlwaysScrollableScrollPhysics(),
        );

        if (_onPullRefresh != null) {
          listBuilderWidget = RefreshIndicator(
            child: listBuilderWidget,
            onRefresh: _onPullRefresh,
          );
        }

        return MyTable.vertical(
          [
            header,
            Expanded(child: listBuilderWidget),
          ],
        );
      },
    );
  }

  Widget headerView() {
    return Container();
  }

  @override
  void onDestroy() {
    _filterList.stop();
    super.onDestroy();
  }
}

abstract class MyListComponent<B extends MyBloc, V extends View, E> extends MyComponent<B, V>
    implements View {
  final FilterList<E> _filterList = FilterList();

  IconData _emptyIcon;
  String _emptyString;
  Widget _emptyWidget;
  ScrollController _controller;

  //TODO must be refactoring
  BuildContext contentContext;

  bool _onTheTop = true;

  bool _onBottom = true;

  @override
  void onCreate() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.onCreate();
  }

  void setItems(List<E> items) {
    _filterList.filter(items);
  }

  List<E> getItems() {
    return _filterList?.filterItems?.value ?? [];
  }

  int getSize() {
    return _filterList._items.length;
  }

  void setEmptyIcon(IconData icon) {
    _emptyIcon = icon;
  }

  void setEmptyString(String message) {
    _emptyString = message;
  }

  /// notify when [ListView] reached its last element
  void didEndList() {
    print("didEndList");
  }

  /// notify when [ListView] reached its top
  void didReachedTop() {
    print("didReachedTop");
  }

  /// listen scroll delegate
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 20) {
      if (!_onBottom) {
        _onBottom = true;
        didEndList();
      }
    } else {
      _onBottom = false;
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      if (!_onTheTop) {
        _onTheTop = true;
        didReachedTop();
      }
    } else {
      _onTheTop = false;
    }
  }

  void setEmptyWidget(Widget widget) {
    _emptyWidget = widget;
  }

  Widget adapterPrePopulateWidget(BuildContext context, E item, int currentIndex) {
    return null;
  }

  Widget adapterPopulateWidget(BuildContext context, E element);

  Widget _emptyContent(BuildContext context) {
    if (_emptyWidget != null) {
      return _emptyWidget;
    }

    if (_emptyIcon == null && _emptyString == null) {
      return Container();
    }

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Padding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(_emptyIcon, size: 150, color: Colors.black12),
                Padding(
                  child: Text(_emptyString ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54, fontSize: 22)),
                  padding: const EdgeInsets.all(24),
                ),
              ],
            ),
            padding: const EdgeInsets.only(bottom: 36),
          ),
        )
      ],
    );
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    final header = headerView();
    return StreamBuilder(
      initialData: null,
      stream: _filterList.getFilterItemsSubject(),
      builder: (buildContext, snapshot) {
        if (snapshot.data == null || (snapshot.data as Iterable<E>).isEmpty) {
          return MyTable.vertical([headerView(), _emptyContent(context)]);
        }

        List<E> list = snapshot.data;
        return Column(children: [
          header,
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemBuilder: (buildContext, index) {
                final item = list[index];
                final itemWidget = adapterPrePopulateWidget(buildContext, item, index);
                if (itemWidget != null) {
                  return itemWidget;
                }
                return adapterPopulateWidget(buildContext, item);
              },
              itemCount: list.length,
            ),
          ),
        ]);
      },
    );
  }

  Widget headerView() {
    return Container();
  }

  @override
  void onDestroy() {
    this._filterList.stop();
    super.onDestroy();
  }
}

class FilterList<E> {
  List<E> _items;

  // ignore: close_sinks
  BehaviorSubject<List<E>> filterItems = BehaviorSubject.seeded([]);

  Predicate<E> _filterPredicate;
  Predicate<E> _searchPredicate;

  void setFilterPredicate(Predicate<E> predicate) {
    _filterPredicate = predicate;
    filter(_items);
  }

  void setSearchPredicate(Predicate<E> predicate) {
    _searchPredicate = predicate;
    filter(_items);
  }

  Subject<Iterable<E>> getFilterItemsSubject() {
    filterItems ??= BehaviorSubject.seeded(_items ?? []);
    return filterItems;
  }

  void filter(List<E> items) {
    _items = items;

    Iterable<E> result;

    if (_searchPredicate == null && _filterPredicate == null) {
      result = _items;
    } else {
      result = items;
      if (_searchPredicate != null) {
        result = result.where(_searchPredicate);
      }
      if (_filterPredicate != null) {
        result = result.where(_filterPredicate);
      }
    }

    if (result == null) {
      return;
    }

    if (filterItems == null) {
      filterItems = BehaviorSubject.seeded(result.toList());
    } else {
      filterItems.add(result.toList());
    }
  }

  void stop() {
    if (filterItems != null && !filterItems.isClosed) {
      filterItems.close();
      filterItems = null;
    }
  }
}
