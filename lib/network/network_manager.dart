import 'dart:collection';

import 'package:first_app/network/network_connectivity.dart';

class NetworkManager {
  // static const String LOGON_DEVICE = "b/core/s:logon_device";

  static Map<String, NetworkManager> _instance = HashMap();

  factory NetworkManager.instance({String accountId}) {
    if (accountId != null && accountId.length != 0) {
      if (_instance.containsKey(accountId)) {
        return _instance[accountId];
      } else {
        _instance[accountId] = NetworkManager();
        return _instance[accountId];
      }
    }
    return NetworkManager();
  }

  static NetworkConnectivity _networkConnectivity;

  static NetworkConnectivity networkConnectivity() {
    if (_networkConnectivity == null) {
      _networkConnectivity = NetworkConnectivity();
    }
    return _networkConnectivity;
  }

  NetworkManager();

/*  @override
  Future<dynamic> auth(String serverId, String login, String password, String serverUrl) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String build = "unknown";
    String versionRelease = "unknown";
    String sdkInt = "unknown";
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo os = await deviceInfo.androidInfo;
      build = os.model;
      versionRelease = os.version.release;
      sdkInt = os.version.sdkInt.toString();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo os = await deviceInfo.iosInfo;
      build = os.utsname.machine;
      versionRelease = os.utsname.release;
      sdkInt = os.utsname.version.substring(0, 20);
    }

    final uuid = await LoginPref.getOrCreateUUID();

    List<String> body = [
      login.trim(),
      password,
      "",
      build,
      uuid,
      versionRelease,
      sdkInt,
      packageInfo.buildNumber,
      packageInfo.version,
      defaultTargetPlatform == TargetPlatform.android ? "A" : "I",
      serverId,
    ];

    Log.debug("Auth.body($body)");
    return Network.post(serverUrl, LOGON_DEVICE)
        .body(body)
        .go()
        .then((value) => json.decode(value));
  }

  @override
  Future<dynamic> sendRecoverPasswordMessage(
      String serverUrl, String login, String langCode) async {
    Map<String, String> body = {"login": login.trim(), "lang_code": langCode};

    Log.debug("Auth.body($body)");
    return Network.post(serverUrl, SEND_RECOVER_PASSWORD_MESSAGE)
        .body(body)
        .connectionTimeout(60 * 1000)
        .go()
        .then((value) => json.decode(value));
  }

  @override
  Future<dynamic> checkRecoverPasswordMessage(
    String serverUrl,
    String token,
    String langCode,
    int code,
  ) async {
    Map<String, String> body = {"token": token, "code": code.toString(), "lang_code": langCode};

    return Network.post(serverUrl, CHECK_RECOVER_PASSWORD_CODE)
        .body(body)
        .go()
        .then((value) => json.decode(value));
  }

  @override
  Future<dynamic> editPassword(
      Server server, String oldPassword, String newPassword, String rewrittenPassword) async {
    Map<String, String> body = {
      "current_password": oldPassword.trim(),
      "new_password": newPassword.trim(),
      "rewritten_password": rewrittenPassword.trim(),
    };

    return Network.post(server.url, EDIT_PASSWORD)
        .headerToken(server.token)
        .connectionTimeout(60 * 1000)
        .body(body)
        .go();
  }

  Future<dynamic> changePassword(
    String serverUrl,
    String password,
    String token,
    int code,
  ) async {
    Map<String, String> body = {"password": password, "token": token, "code": code.toString()};

    return Network.post(serverUrl, CHANGE_PASSWORD).body(body).go().then((value) => value);
  }

  @override
  Future<dynamic> userInfos(Server server, String langCode) async {
    try {
      final jsonResult = await Network.get(server.url, SESSION_INFO_MOBILE)
          .header("lang_code", langCode)
          .headerToken(server.token)
          .go();

      return json.decode(jsonResult);
    } catch (error, stacktrace) {
      Log.error("UserInfo(${error.toString()} => ${stacktrace.toString()})");
      rethrow;
    }
  }

  @override
  Future<dynamic> loadUserActiveSessions(Server server) async {
    final jsonResult =
        await Network.post(server.url, USER_SESSION_LIST).headerToken(server.token).go();

    return json.decode(jsonResult);
  }

  @override
  Future<dynamic> deleteUserActiveSession(Server server, Filial filial, String hostId) async {
    */ /*  Map<String, String> body = {"host_id": hostId};

    final jsonResult = await Network.post(server.url, DELETE_USER_SESSION)
        .headerToken(server.token)
        .header("project_code", filial.projectCode)
        .body(body)
        .go();
    return jsonResult;*/ /*
  }

  @override
  Future<void> saveAccountCode(Server server, String accountCode) async {
    try {
      await Network.post(server.url, SAVE_ACCOUNT_CODE)
          .headerToken(server.token)
          .body(accountCode)
          .go();
    } catch (error, stacktrace) {
      Log.error(error, stacktrace);
      rethrow;
    }
  }*/

  static void dispose() {
    _networkConnectivity?.dispose();
  }
}
