import 'package:gwslib/gwslib.dart';

class AccountErrorTranslator {
  static String t(String key) => "gwslib:error:$key".translate();

  static String accountT(String key) => "account:error:$key".translate();

  static final String CONNECTION_FAIL = "Connection failed".toLowerCase();
  static final String CONNECTION_FAIL_2 = "socketexception: failed host lookup:".toLowerCase();
  static final String CONNECTION_FAIL_3 = "failed to connect to".toLowerCase();
  static final String CONNECTION_REFUSED = "Connection refused".toLowerCase();
  static final String HTTP_NOT_FOUND = "Status 404".toLowerCase();
  static final String HTTP_NOT_FOUND2 = "Http status error [404]".toLowerCase();
  static final String CONNECTION_TIMEOUT = "Connection timed out".toLowerCase();
  static final String CONNECTION_TIMEOUT_2 = "Connecting timed out".toLowerCase();
  static final String OAUTH_NUMERIC_OR_VALUE = "numeric or value".toLowerCase();
  static final String NUMBER_INVALID_FORMAT = "FormatException: Invalid radix".toLowerCase();
  static final String INVALID_URL = "Invalid argument(s): No host specified in URI ".toLowerCase();
  static final String TLS_RECORD_242 = "tls_record.cc:242".toLowerCase();
  static final String FAILED_HOST = "Failed host lookup".toLowerCase();
  static final String SOCKET_EXCEPTION = "SocketException".toLowerCase();
  static final String UNBALE_TO_RESOLVE = "unable to resolve host".toLowerCase();
  static final String NUMERIC_OR_VALUE = "numeric or value".toLowerCase();
  static final String NO_DATA_FOUND = "no data found".toLowerCase();
  static final String CONNECTION_TIMEOUT_3 = "the operation couldn't be completed".toLowerCase();

  static String translateError(String error) {
    if (error == null) return null;
    String err = error.toLowerCase();
    if (err.contains(CONNECTION_FAIL) ||
        err.contains(CONNECTION_FAIL_2) ||
        err.contains(CONNECTION_FAIL_3) ||
        err.contains(UNBALE_TO_RESOLVE)) {
      return t("error_conection_fail");
    } else if (err.contains(CONNECTION_REFUSED)) {
      return t("error_conection_refused");
    } else if (err.contains(HTTP_NOT_FOUND) || err.contains(HTTP_NOT_FOUND2)) {
      return t("error_http_not_found");
    } else if (err.contains(CONNECTION_TIMEOUT) ||
        err.contains(CONNECTION_TIMEOUT_2) ||
        err.contains(CONNECTION_TIMEOUT_3)) {
      return t("error_connection_timeout");
    } else if (err.contains(OAUTH_NUMERIC_OR_VALUE)) {
      return t("error_incorrect_login_or_password");
    } else if (err.contains(NUMBER_INVALID_FORMAT)) {
      return accountT("error_number_invalid_format");
    } else if (err.contains(INVALID_URL)) {
      return accountT("error_invalid_url");
    } else if (err.contains(TLS_RECORD_242)) {
      return accountT("error_tls_record_242");
    } else if (err.contains(FAILED_HOST)) {
      return t("error_failed_host");
    } else if (err.contains(NO_DATA_FOUND)) {
      return t("error_no_data_found");
    } else if (err.contains(NUMERIC_OR_VALUE)) {
      return t("error_numeric_or_value");
    } else if (err.contains(SOCKET_EXCEPTION)) {
      return t("error_socket_exception");
    }

    return error;
  }
}
