import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/app/app_life.dart';
import 'package:flutter_template/app/default_app.dart';
import 'package:flutter_template/utils/device_util/device_util.dart';
import 'package:flutter_template/utils/log_util/log_config.dart';
import 'package:flutter_template/utils/log_util/log_manager.dart';
import 'package:flutter_template/utils/log_util/log_print.dart';
import 'package:flutter_template/utils/package_util/package_util.dart';
import 'package:flutter_template/utils/sp_util/sp_utils.dart';

class AppInit {
  static Future<void> initApp() async {
    /// 确保初始化完成
    WidgetsFlutterBinding.ensureInitialized();
    // 锁定竖屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //主动获取生命周期
    AppLifeState.appLifecycleState =
        WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.resumed;
    //初始化网络状态
    Connectivity().checkConnectivity().then((value) {
      AppLifeState.connectivityResult = value;
    });
    //日志打印初始化
    LogManager.init(
      config: LogConfig(enable: true, globalTag: "NO TAG", stackTraceDepth: 5),
      printers: [ConsolePrint()],
    );
    //package_info
    await PackageUtil().getInfo();
    //device_info初始化
    await DeviceUtil().initDeviceInfoUtils();
    //存储初始化
    await SPUtil.init();
    runApp(const AppLife(child: DefaultApp()));
  }
}
