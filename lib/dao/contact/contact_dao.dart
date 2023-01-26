import 'package:first_app/dao/dao.dart';
import 'package:first_app/kernel/bean/contact_model.dart';
import 'package:first_app/kernel/contact/md_api.dart';
import 'package:first_app/kernel/contact/table/users.dart';
import 'package:sqflite/sqflite.dart';

class ContactDaoImpl extends ContactDao {
  Database db;

  ContactDaoImpl(this.db);

  @override
  Future<void> saveContact(MdUsers contact) => MdApi.saveContact(db, contact);

  @override
  Future<List<ContactData>> loadData() {
    const sql = """ SELECT t.*  FROM ${MdUsers.TABLE_NAME} t""";

    return db.rawQuery(sql).then((value) => value.map((e) => ContactData.fromData(e)).toList());
  }
}
