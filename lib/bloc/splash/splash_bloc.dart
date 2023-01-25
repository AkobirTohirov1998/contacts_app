import 'package:first_app/bloc/bloc.dart';
import 'package:first_app/bloc/kernel/my_bloc.dart';
import 'package:first_app/screen/view.dart';

class SplashBlocImpl extends MyBlocImpl<SplashView> implements SplashBloc {
  SplashBlocImpl(SplashView view) : super(view);
}
