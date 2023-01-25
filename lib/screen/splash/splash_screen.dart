import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/screen/intro/intro_screen.dart';
import 'package:first_app/screen/my_screen.dart';
import 'package:first_app/screen/view.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class SplashScreen extends MyScreen<SplashBloc, SplashView> implements SplashView {
  static final ROUTE_NAME = "/";

  @override
  void onCreate() {
    setFragmentScrollable(false);
    setBackgroundColor(exampleColors.background);
    Future.delayed(const Duration(milliseconds: 2000), () {
      IntroScreen.replace(getContext());
    });
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [exampleColors.background, exampleColors.accent])),
      child: Center(
          child: MyText("Splash Screen", style: textStyle.title_2(color: exampleColors.green))),
    );
  }
}
