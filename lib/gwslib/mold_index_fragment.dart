import 'package:first_app/gwslib/mold_content_fragment.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

abstract class MoldIndexFragment<VM extends ViewModel> extends ViewModelFragment<VM> {
  final LazyStream<RootFragment> _contentControler = LazyStream();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  ///close the drawer
  void closeDrawer() {
    Navigator.pop(_scaffoldKey.currentContext);
  }

  void showToast(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: MyText(message)));
  }

  void openContent(RootFragment content) {
    content.drawerScaffoldKey = _scaffoldKey;
    _contentControler.value?.onDestroy();
    _contentControler.add(content);
  }

  RootFragment getContentFragment() {
    return _contentControler.value;
  }

  Widget onCreateView(BuildContext context);

  @override
  Widget onCreateWidget(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder(
          stream: _contentControler.stream,
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }

            MoldContentFragment fragment = snapshot.data;
            fragment.context = context;
            if (fragment.viewmodel == null) {
              fragment.onCreate(context);
            }
            return Container(child: fragment.onCreateWidget(context));
          },
        ),
        drawer: Drawer(child: onCreateView(context)),
      ),
    );
  }

  @override
  void onDestroy() {
    super.onDestroy();
    _contentControler.value?.onDestroy();
    _contentControler.close();
  }
}
