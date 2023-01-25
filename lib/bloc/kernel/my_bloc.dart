import 'package:first_app/bloc/kernel/bloc.dart';
import 'package:first_app/common/message.dart';
import 'package:first_app/dao/dao.dart';
import 'package:first_app/dao/dao_provider.dart';
import 'package:first_app/screen/view.dart';
import 'package:gwslib/common/lazy_stream.dart';

abstract class MyBlocImpl<V extends View> extends MyBloc {
  final V view;

  MyBlocImpl(this.view);

  Dao daos<B extends Bloc>(MyBloc bloc) => DaoProvider.of(bloc).get(B);

  @override
  void onCreate() {}

  //abstract functions
  Stream<Message> getMessageStream() => _message.stream;

  LazyStream<Message> _message = LazyStream();

  Message get getMessage => _message.value;

  LazyStream<bool> _progress = LazyStream();

  bool get isProgress => _progress.value;

  @override
  Stream<bool> getProgressStream() => _progress.stream;

  void setMessage(Message message) {
    _message.add(message);
  }

  void setWarningMessage(dynamic message, [String description]) {
    String messageText;
    String descriptionText = description;
    if (message is ErrorMessage) {
      messageText = message.messageText;
      descriptionText = message.stacktrace;
    } else if (message is String) {
      messageText = message;
    } else {
      throw UnsupportedError("message type not support, you can use String or ErrorMessage");
    }
    _message.add(WarningMessage(messageText, description: descriptionText));
  }

  void setErrorMessage(dynamic error, [dynamic stacktrace]) {
    ErrorMessage errorMessage;
    if (!(error is ErrorMessage)) {
      errorMessage = ErrorMessage.parseWithStacktrace(error, stacktrace);
    } else {
      errorMessage = error;
    }
    _message.add(errorMessage);
  }

  void resetMessage() {
    _message.add(null);
  }

  void setProgress(bool progress) {
    _progress.add(progress);
  }

  void resetProgress() {
    _progress.add(false);
  }

  void onDestroy() {
    _message.close();
    _progress.close();
  }
}
