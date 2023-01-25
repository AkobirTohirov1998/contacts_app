import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:first_app/widgets/card.dart';
import 'package:first_app/widgets/item.dart';
import 'package:first_app/widgets/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class ContactScreen extends MyScreen<ContactBloc, ContactView> implements ContactView {
  static final ROUTE_NAME = "/";

  @override
  void onCreate() {
    setBackgroundColor(exampleColors.background);
    setFragmentScrollable(false);

    setFloatActionButton(FloatingActionButton(child: MyIcon(icon: Icons.add), onPressed: () {}));
    super.onCreate();
  }

  @override
  PreferredSizeWidget onBuildAppBarWidget(BuildContext context) {
    return GLToolbar(title: "Contacts", leading: MyIcon());
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return VCard.child(
              child: MyTable(
                [
                  GLItem.build(title: "AKOBiR", onTap: () {}),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4));
        });
  }
}
