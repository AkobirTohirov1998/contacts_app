import 'package:first_app/kernel/bean/contact_model.dart';
import 'package:first_app/kernel/contact/table/users.dart';
import 'package:sqflite_common/sqlite_api.dart';

abstract class Dao {}

abstract class ContactDao extends Dao {

  Future<List<ContactData>> loadData();

  Future<void> saveContact(MdUsers contact);
}
