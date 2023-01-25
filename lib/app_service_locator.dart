import 'package:first_app/dao/login/login_service.dart';
import 'package:first_app/network/network_manager.dart';
import 'package:sqflite/sqflite.dart';

class AppServiceLocator {
  Database Function() database;

  AppServiceLocator(this.database);

  LoginService _loginService;

  LoginService get loginService {
    if (_loginService == null || _loginService?.db?.isOpen != true) {
      _loginService = LoginService(database.call(), NetworkManagerImpl.getInstance());
    }
    return _loginService;
  }
}
