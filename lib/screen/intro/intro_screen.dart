import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends MyScreen<IntroBloc, IntroView> implements IntroView {
  static final ROUTE_NAME = "/intro_screen";

  static void replace(BuildContext context) {
    // final bundle = Bundle.newBundle(context);
    // bundle.putObject("arg_login", argLogin);
    Mold.replaceRoute(context, ROUTE_NAME);
  }

  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: MyText("Intro")),
        body: IntroductionScreen(
          pages: pageList(),
          showSkipButton: true,
          showNextButton: true,
          next: MyIcon(icon: Icons.arrow_forward, color: exampleColors.accent),
          skip: const Text("Skip"),
          done: const Text("Done"),
          onDone: () {},
          onSkip: () {},
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: exampleColors.green,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          ),
        ));
  }

  List<PageViewModel> pageList() {
    return [
      PageViewModel(
        title: "Title of custom body page",
        bodyWidget: MyTable.horizontal([
          MyText("Click on "),
          MyIcon(icon: Icons.edit),
          MyText(" to edit a post"),
        ], mainAxisAlignment: MainAxisAlignment.center),
        image: const Center(child: Icon(Icons.android)),
      ),
      PageViewModel(
        title: "Title of custom body page",
        bodyWidget: MyTable.horizontal([
          MyText("Click on "),
          MyIcon(icon: Icons.factory),
          MyText(" to edit a post"),
        ], mainAxisAlignment: MainAxisAlignment.center),
        image: const Center(child: Icon(Icons.factory)),
      ),
      // PageViewModel(),
      // PageViewModel()
    ];
  }
}
