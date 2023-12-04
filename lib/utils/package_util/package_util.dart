import 'package:package_info_plus/package_info_plus.dart';

class PackageUtil {
  PackageUtil._internal();

  static final PackageUtil _instance = PackageUtil._internal();
  factory PackageUtil() => _instance;

  late PackageInfo packageInfo;

  Future<void> getInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
