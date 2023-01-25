import 'dart:io';

import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:first_app/widgets/bottom_navigation.dart';
import 'package:first_app/widgets/message_screen.dart';
import 'package:first_app/widgets/progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:provider/provider.dart';

abstract class VMyScreen<B extends MyBloc, V extends View> extends MyScreen<B, V> {
  @override
  Widget onCreateWidget(BuildContext context) {
    return ChangeNotifierProvider<MyScreenNotifier>.value(
      value: notifier,
      child: Consumer<MyScreenNotifier>(builder: (_, model, child) {
        final ctx = getContext();
        final notifier = model;

        Widget bodyWidget = MyTable.vertical([
          if (onBuildAppBarWidget(context) != null) onBuildAppBarWidget(context),
          MessageScreenWidget(myBloc.getMessageStream(), onCloseTap: () => myBloc.resetMessage()),
          onBuildBodyWidget(ctx)
        ]);

        if (notifier.isScrollable) {
          bodyWidget = SingleChildScrollView(child: bodyWidget);
        }

        return Stack(
          children: [
            Scaffold(
              backgroundColor: notifier.getBackgroundColor,
              floatingActionButton: notifier.getFloatActionButton,
              bottomNavigationBar: onBuildBottomNavigationBar(getContext()),
              body: SafeArea(
                top: Platform.isIOS,
                child: bodyWidget,
              ),
            ),
            ProgressScreenWidget(myBloc.getProgressStream())
          ],
        );
      }),
    );
  }

  @override
  Widget onBuildBottomNavigationBar(BuildContext context) {
    return VBottomNavigation.withBackPress(screenContext: getContext(), actions: []);
  }
}
