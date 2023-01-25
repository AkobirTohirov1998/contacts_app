import 'package:package_info/package_info.dart';

class AppUtil {
  static Future<String> getAppCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}
