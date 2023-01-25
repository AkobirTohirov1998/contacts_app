import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/dao/dao.dart';
import 'package:first_app/kernel/database.dart';
import 'package:first_app/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

typedef OnBlocBuilder<R, T> = R Function(T bloc);

class DaoProvider<R extends Dao, T extends MyBloc> {
  static final Map<Type, OnBlocBuilder<Dao, MyBloc>> _data = {};

  static void register(Type type, OnBlocBuilder<Dao, MyBloc> builder) {
    _data[type] = builder;
  }

  static NetworkManager get networkManager => NetworkManagerImpl.getInstance();

  static Database _getDatabase() {
    final db = AppExampleDatabase.getInstance();
    return db.getDatabase();
  }

  static void init() {
    // register(IntroBloc, (bloc) => IntroDaoImpl(_getDatabase()));
    // register(LoginAccountBloc, (bloc) => LoginService(_getDatabase(), networkManager));
    // register(FilialListBloc, (bloc) => FilialListDaoImpl(_getDatabase()));
    // register(AccountListBloc, (bloc) => AccountListDaoImpl(_getDatabase()));
    // register(SelectAccountListBloc, (bloc) => SelectAccountListDaoImpl(_getDatabase()));
    // register(EditPasswordBloc, (bloc) => EditPasswordDaoImpl(_getDatabase()));
  }

  static DaoProvider of(MyBloc bloc) {
    return DaoProvider._(bloc);
  }

  @visibleForTesting
  static void registerMock(Type type, Dao dao) {
    register(type, (bloc) => dao);
  }

  final MyBloc _bloc;

  DaoProvider._(this._bloc);

  R get(Type type) {
    if (_data.containsKey(type)) {
      return _data[type].call(this._bloc);
    }
    throw UnsupportedError("Unsupported type=${type.runtimeType.toString()}");
  }
}
