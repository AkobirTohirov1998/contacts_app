import 'package:first_app/kernel/contact/table/users.dart';
import 'package:sqflite/sqflite.dart';

class MdApi {
  static Future<void> saveContact(Database db, MdUsers contact) {
    return Z_MdUsers.saveRow(db, contact);
  }
}
