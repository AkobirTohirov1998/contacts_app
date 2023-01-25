import 'package:gwslib/common/error_message.dart';

class MyResult<T> {
  T data;

  MyResult(this.data);
}

class MySuccessResult<T> extends MyResult<T> {
  MySuccessResult(T data) : super(data);
}

class MyErrorResult<T> extends MyResult<T> {
  String errorMessage;

  MyErrorResult(String e) : super(null) {
    errorMessage = e;
  }

  MyErrorResult.exception(e) : super(null) {
    errorMessage = ErrorMessage.parse(e).messageText;
  }
}
