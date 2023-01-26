import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/kernel/bean/contact_model.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:first_app/widgets/button.dart';
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

    setFloatActionButton(FloatingActionButton(
      child: MyIcon(icon: Icons.add),
      onPressed: showAddContactDialog,
    ));
    super.onCreate();
  }

  @override
  PreferredSizeWidget onBuildAppBarWidget(BuildContext context) {
    return GLToolbar(title: "Contacts", leading: MyIcon());
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return StreamBuilder<List<ContactData>>(
        stream: bloc.contactListStream,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final contact = snapshot.data[index];
                return VCard.child(
                    child: MyTable(
                      [
                        GLItem.build(
                            iconWidget: MyIcon(icon: Icons.person),
                            title: contact.name,
                            subtitle: contact.phoneNumber,
                            onTap: () {}),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4));
              });
        });
  }

  void showAddContactDialog() {
    TextEditingController _contactNameController = TextEditingController();
    TextEditingController _contactPhoneNumberController = TextEditingController();
    showDialog<bool>(
        context: getContext(),
        builder: (BuildContext context) {
          return AlertDialog(
              title: MyText("Name", style: textStyle.title_5()),
              content: Builder(builder: (context) {
                var width = MediaQuery.of(context).size.width;
                return MyTable.vertical([
                  GEditText(
                      style: textStyle.title_5(),
                      maxLength: 50,
                      controller: _contactNameController),
                  GEditText(
                      style: textStyle.title_5(),
                      maxLength: 50,
                      controller: _contactPhoneNumberController)
                ], width: width - 20);
              }),
              actions: <Widget>[
                MyTable.horizontal([
                  GLButton(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      text: "Cancel",
                      textStyle: textStyle.paragraphBold(color: Colors.blue),
                      onTap: () {
                        Mold.onContextBackPressed(context);
                      }),
                  GLButton(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      text: "Ok",
                      textStyle: textStyle.paragraphBold(color: Colors.blue),
                      onTap: () {
                        bloc.saveContact(ContactData(
                            DateTime.now().millisecondsSinceEpoch,
                            _contactNameController.text.toString(),
                            _contactPhoneNumberController.text.toString(),
                            ''));
                        Mold.onContextBackPressed(context, true);
                      })
                ])
              ]);
        }).then((isCreated) {
      if (isCreated == true) {
        bloc?.loadData();
      }
    });
  }
}
