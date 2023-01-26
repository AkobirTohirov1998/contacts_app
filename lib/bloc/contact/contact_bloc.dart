import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/bloc/kernel/my_bloc.dart';
import 'package:first_app/dao/dao.dart';
import 'package:first_app/kernel/bean/contact_model.dart';
import 'package:first_app/kernel/contact/table/users.dart';
import 'package:first_app/screen/view.dart';
import 'package:gwslib/gwslib.dart';

class ContactBlocImpl extends MyBlocImpl<ContactView> implements ContactBloc {
  ContactBlocImpl(ContactView view) : super(view);

  ContactDao dao;

  final LazyStream<List<ContactData>> _contacts = LazyStream(() => []);

  @override
  Stream<List<ContactData>> get contactListStream => _contacts.stream;

  @override
  List<ContactData> get contacts => _contacts.value;

  @override
  void onCreate() {
    daos<ContactBloc>(this);
    super.onCreate();
  }

  @override
  Future<List<ContactData>> loadData() async {
    try {
      setProgress(true);
      List<ContactData> contacts = await dao.loadData();
      _contacts.add(contacts);
    } catch (e, st) {
      Log.error(e, st);
      setErrorMessage(e, st);
    } finally {
      setProgress(false);
    }
  }

  @override
  Future<void> saveContact(ContactData contact) async {
    try {
      setProgress(true);
      final row =
          MdUsers(userId: contact.userId, name: contact.name, phoneNumber: contact.phoneNumber);

      await dao.saveContact(row);
    } catch (e, st) {
      setErrorMessage(e, st);
    } finally {
      setProgress(false);
    }
  }
}
