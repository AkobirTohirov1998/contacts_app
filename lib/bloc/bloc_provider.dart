import 'package:first_app/bloc/contact/contact_bloc.dart';
import 'package:first_app/bloc/intro/intro_bloc.dart';
import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/bloc/splash/splash_bloc.dart';
import 'package:first_app/network/network_manager.dart';
import 'package:first_app/screen/view.dart';

typedef OnBlocBuilder<R, T> = R Function(T view);

class BlocProvider<R extends Bloc, T extends View> {
  static final Map<Type, OnBlocBuilder<Bloc, View>> _data = {};

  static void register(Type type, OnBlocBuilder<Bloc, View> builder) {
    _data[type] = builder;
  }

  static NetworkManager get networkManager => NetworkManager.instance();

  static void init() {
    register(SplashView, (view) => SplashBlocImpl(view));
    register(IntroView, (view) => IntroBlocImpl(view));
    register(ContactView, (view) => ContactBlocImpl(view));
    // register(LocalAuthenticationView, (view) => LocalAuthenticationBlocImpl(view));
    // register(PasscodeView, (view) => PasscodeBlocImpl(view));
    // register(LoginAccountView, (view) => LoginAccountBlocImpl(view));
    // register(EditPasswordView, (view) => EditPasswordBlocImpl(view, networkManager));
    // register(RecoveryPasswordView, (view) => RecoveryPasswordBlocImpl(view, networkManager));
    // register(RecoverPasswordCodeView, (view) => RecoverPasswordCodeBlocImpl(view, networkManager));
    // register(ChangePasswordView, (view) => ChangePasswordBlocImpl(view, networkManager));
    // register(FilialListView, (view) => FilialListBlocImpl(view, networkManager));
    // register(AccountListView, (view) => AccountListBlocImpl(view));
    // register(SelectAccountListView, (view) => SelectAccountListBlocImpl(view));
    // register(UserActiveSessionsView, (view) => UserActiveSessionsBlocImpl(view, networkManager));
    // register(SelectServerUrlView, (view) => SelectServerUrlBlocImpl(view));
    // register(PhotoViewerView, (view) => PhotoViewerBlocImpl(view));
    // register(VideoViewerView, (view) => VideoViewerBlocImpl(view));
    // register(VideoViewerItemView, (view) => VideoViewerItemBlocImpl(view));
    // register(SelectLanguageDialogView, (view) => SelectLanguageDialogBlocImpl(view));
  }

  static BlocProvider of(View view) {
    return BlocProvider._(view);
  }

  final View _view;

  BlocProvider._(this._view);

  R get(Type type) {
    if (_data.containsKey(type)) {
      return _data[type].call(this._view);
    }
    throw UnsupportedError("Unsupported type=$type");
  }
}
