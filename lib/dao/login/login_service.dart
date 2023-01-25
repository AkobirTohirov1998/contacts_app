import 'package:first_app/dao/dao.dart';
import 'package:first_app/network/network_manager.dart';
import 'package:sqflite/sqflite.dart';

class LoginService extends Dao {
  final Database db;
  final NetworkManager networkManager;

  LoginService(this.db, this.networkManager);
}
