import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/kernel/bean/contact_model.dart';

abstract class IntroBloc extends MyBloc {}

abstract class SplashBloc extends MyBloc {}

abstract class ContactBloc extends MyBloc {
  Stream<List<ContactData>> get contactListStream;

  List<ContactData> get contacts;

  Future<List<ContactData>> loadData();

  Future<void> saveContact(ContactData contact);
}
