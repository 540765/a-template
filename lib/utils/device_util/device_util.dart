import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/utils/package_util/package_util.dart';
import 'package:uuid/uuid.dart';

class DeviceUtil {
  DeviceUtil._internal();

  static final DeviceUtil _instance = DeviceUtil._internal();

  factory DeviceUtil() {
    //需要手动初始化
    return _instance;
  }

  static const FlutterSecureStorage flutterSecureStorage =
      FlutterSecureStorage();

  /// ios设备信息
  late IosDeviceInfo iosDeviceInfo;

  /// 安卓端设备信息
  late AndroidDeviceInfo androidInfo;

  /// 每次APP启动后生成一个新的UUID
  String? lanId;

  ///设备id
  String deviceId = "";

  ///需要确保全局只调用一次
  Future<void> initDeviceInfoUtils() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }

    ///唯一id
    String key = "${PackageUtil().packageInfo.appName}_deviceId";

    String? id = await flutterSecureStorage.read(key: key);
    if (id == null) {
      //写入id
      deviceId = const Uuid().v4();
      await flutterSecureStorage.write(key: key, value: deviceId);
    } else {
      //有,获取
      deviceId = id;
    }
  }

  //如果使用AndroidId获取需要注意隐私协议
  //<uses-permission android:name="com.google.android.gms.permission.AD_ID"/>
}
