import 'package:app_metrica/app_metrica.dart';
import 'package:first_app/app_service_locator.dart';
import 'package:first_app/bloc/bloc_provider.dart';
import 'package:first_app/common/resources.dart';
import 'package:first_app/dao/dao_provider.dart';
import 'package:first_app/kernel/database.dart';
import 'package:first_app/localization/error_translator.dart';
import 'package:first_app/localization/translates.dart';
import 'package:first_app/pref/system_pref.dart';
import 'package:first_app/resources/colors_dark.dart';
import 'package:first_app/resources/colors_light.dart';
import 'package:first_app/resources/theme.dart';
import 'package:first_app/screen/contact/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

void main() {
  final app = ExampleApp();
  Mold.startApplication(app);
}

class ExampleApp extends MoldApplication {
  static ExampleApp _instance;

  static ExampleApp getInstance() => _instance;

  @visibleForTesting
  static setAccountApp(ExampleApp mockApp) {
    _instance = mockApp;
  }

  String getDefaultServer() {
    return "https://trade.smartup.one/";
  }

  @override
  Future<MoldColor> getColor() {
    return SystemPref.getThemeType().then((themeType) {
      if (themeType == SystemPref.cThemeSystem) {
        final window = WidgetsBinding.instance.window;
        final pb = MediaQueryData.fromWindow(window).platformBrightness;
        if (pb == Brightness.dark) {
          themeType = SystemPref.cThemeDark;
        } else {
          themeType = SystemPref.cThemeLight;
        }
      }
      if (themeType == SystemPref.cThemeLight) {
        return LightAccountAppColor();
      } else if (themeType == SystemPref.cThemeDark) {
        return DarkAccountAppColor();
      }
      return LightAccountAppColor();
    });
  }

  @override
  Future<MoldTheme> getTheme() {
    return Future.value(ExampleAppTheme());
  }

  List<String> supportedProjectCodes() {
    return [];
  }

  @override
  void onCreate() {
    super.onCreate();
    _instance = this;
    DaoProvider.init();
    BlocProvider.init();
    AssertsColors.init();
  }

  Widget analyticScreen(String name, Widget screen) {
    Log.debug("AppMetric: $name");

    AppMetricaPlugin.reportEvent("open " + "report_definition:$name".translate());
    return screen;
  }

  @override
  Map<String, WidgetBuilder> getRoutes() => {
        ContactScreen.ROUTE_NAME: (context) =>
            analyticScreen(ContactScreen.ROUTE_NAME, Window(ContactScreen()))
        // SplashScreen.ROUTE_NAME: (context) =>
        //     analyticScreen(SplashScreen.ROUTE_NAME, Window(SplashScreen())),
        // IntroScreen.ROUTE_NAME: (context) =>
        //     analyticScreen(IntroScreen.ROUTE_NAME, Window(IntroScreen())),
      };

  @override
  Map<String, String> getTranslates(String langCode) {
    return super.getTranslates(langCode)..addAll(Translates.getTranslates(langCode));
  }

  String translateError(String error) => AccountErrorTranslator.translateError(error);

  Future<void> onOpenSession(String serverId, int filialId, String projectCode) async {}

  AppServiceLocator _accountServiceLocator;

  AppServiceLocator get accountServiceLocator {
    _accountServiceLocator ??=
        AppServiceLocator(() => AppExampleDatabase.getInstance().getDatabase());
    return _accountServiceLocator;
  }
}
