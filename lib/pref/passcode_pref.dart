import 'package:gwslib/preferences/pref.dart';

class PasscodePref {
  static final String _MODULE = "account:passcode:pref";

  static final String _PASSCODE = "passcode";
  static final String _FINGERPRINT = "fingerprint";

  //------------------------------------------------------------------------------------------------

  static Future<String> getServerPasscode(String serverId) =>
      Pref.load(_MODULE, "$_PASSCODE:$serverId");

  static Future<bool> hasServerPasscode(String serverId) {
    return getServerPasscode(serverId).then((passcode) => passcode != null && passcode.length > 0);
  }

  static Future<void> setServerPasscode(String serverId, String passcode) async {
    await Pref.save(_MODULE, "$_PASSCODE:$serverId", passcode);
  }

  static Future<void> deleteServerPasscode(String serverId) async {
    await Pref.save(_MODULE, "$_PASSCODE:$serverId", null);
  }

  //------------------------------------------------------------------------------------------------

  static Future<bool> isEnableFingerprint(String serverId) {
    return Pref.load(_MODULE, "$_FINGERPRINT:$serverId").then((enable) => enable == "Y");
  }

  static Future<void> setEnableFingerprint(String serverId, bool enable) async {
    await Pref.save(_MODULE, "$_FINGERPRINT:$serverId", enable ? "Y" : "N");
  }
}
