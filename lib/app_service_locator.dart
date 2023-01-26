import 'package:first_app/dao/contact/contact_dao.dart';
import 'package:sqflite/sqflite.dart';

class AppServiceLocator {
  Database Function() database;

  AppServiceLocator(this.database);

  ContactDaoImpl _contactDao;

  ContactDaoImpl get developerDao {
    if (_contactDao == null || _contactDao.db.isOpen != true) {
      _contactDao = ContactDaoImpl(database.call());
    }
    return _contactDao;
  }
}
