import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:gwslib/preferences/pref.dart';

class LoginPref {
  static final String _MODULE = "account:login:pref";

  //------------------------------------------------------------------------------------------------
  static final String _DEVICE_UUID = "device_uuid";
  static final String _LAST_SERVER_URL = "last_server_url";
  static final String _SERVER_URLS = "server_urls";
  static const String _IS_RESET_FOR_PUSH = "is_reset_for_push";

  //----------------------------------------------------------------------------
  static Future<String> getOrCreateUUID() async {
    final value = await Pref.load(_MODULE, _DEVICE_UUID);
    if (value != null && value.length > 0) {
      return value;
    } else {
      String identifier = "unknown (not gen)";
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      try {
        if (Platform.isAndroid) {
          var build = await deviceInfoPlugin.androidInfo;
          identifier = build.androidId; //UUID for Android
        } else if (Platform.isIOS) {
          var data = await deviceInfoPlugin.iosInfo;
          identifier = data.identifierForVendor; //UUID for iOS
        }
      } on PlatformException {
        print('Failed to get platform version');
      }

      await Pref.save(_MODULE, _DEVICE_UUID, identifier);

      return identifier;
    }
  }

  static Future<void> saveLastServerUrl(String url) async {
    await Pref.save(_MODULE, _LAST_SERVER_URL, url?.toLowerCase());
    saveServerUrls(url);
  }

  static Future<void> saveServerUrls(String serverUrl) async {
    if (serverUrl == null) return;
    final List<String> serverUrls = await loadServerUrls();
    if (!serverUrls.contains(serverUrl.toLowerCase())) {
      serverUrls.add(serverUrl.toLowerCase());
      final String value = serverUrls.join(";");
      await Pref.save(_MODULE, _SERVER_URLS, value);
    }
  }

  static Future<String> loadLastServerUrl() {
    return Pref.load(_MODULE, _LAST_SERVER_URL);
  }

  static Future<List<String>> loadServerUrls() async {
    final String value = await Pref.load(_MODULE, _SERVER_URLS);
    return value?.split(";") ?? [];
  }

  //----------------------------------------------------------------------------

  static Future<bool> setResetToken(String serverId) {
    return Pref.save(_MODULE, "$serverId:$_IS_RESET_FOR_PUSH", "Y");
  }

  static Future<bool> isResetServerToken(String serverId) async {
    return "Y" == (await Pref.load(_MODULE, "$serverId:$_IS_RESET_FOR_PUSH"));
  }
}
