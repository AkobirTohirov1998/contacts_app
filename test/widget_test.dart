// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:first_app/localization/translates.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("generate new translates", () async {
    Map<String, String> translates = RuTranslates().getTranslate();

    File serverTranslateFile = File.fromUri(Uri.file("server_translates.txt"));

    String fileContent = await serverTranslateFile.readAsString();

    List<String> fileContentList = fileContent.split("\n").map((e) => e.trim()).toList();

    Map<String, String> serverTranslates = {};

    Map<String, String> newTranslates = {};

    for (final content in fileContentList) {
      serverTranslates[content] = "server";
    }

    for (String key in translates.keys) {
      var value = translates[key];
      if (serverTranslates.containsKey(key)) {
        value = "";
      }
      newTranslates[key] = value;
    }

    final translatesForTechWriterFile = File("account_tech_writer_translates.txt");

    final translatesForServerFile = File("account_server_translates.txt");

    String translatesForTech = newTranslates.keys
        .where((e) => newTranslates[e]?.isNotEmpty == true)
        .map((e) => e + " = \"${newTranslates[e]}\"")
        .join("\n");

    await translatesForTechWriterFile.writeAsString(translatesForTech);

    String translatesForServer =
        newTranslates.keys.map((e) => "Add_Translate_Code('$e');").join("\n");

    await translatesForServerFile.writeAsString(translatesForServer);
  });
}
