import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/bloc/kernel/my_bloc.dart';
import 'package:first_app/screen/view.dart';

class IntroBlocImpl extends MyBlocImpl<IntroView> implements IntroBloc {
  IntroBlocImpl(IntroView view) : super(view);
}
