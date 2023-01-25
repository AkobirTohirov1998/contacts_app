import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/bloc/kernel/my_bloc.dart';
import 'package:first_app/screen/view.dart';

class ContactBlocImpl extends MyBlocImpl<ContactView> implements ContactBloc {
  ContactBlocImpl(ContactView view) : super(view);
}
