import 'package:first_app/common/message.dart';

abstract class Bloc {}

abstract class MyBloc extends Bloc {
  void onCreate();

  Stream<Message> getMessageStream();

  Message get getMessage;

  Stream<bool> getProgressStream();

  void resetMessage();

  void onDestroy();
}
