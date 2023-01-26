import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/dao/contact/contact_dao.dart';
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

  static NetworkManager get networkManager => NetworkManager.instance();

  static Database _getDatabase() => AppExampleDatabase.getInstance().getDatabase();

  static void init() {
    register(ContactBloc, (bloc) => ContactDaoImpl(_getDatabase()));
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
