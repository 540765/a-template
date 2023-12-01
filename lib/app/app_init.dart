import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/app/app_life.dart';
import 'package:flutter_template/app/default_app.dart';

class AppInit {
  static Future<void> initApp() async {
    /// 确保初始化完成
    WidgetsFlutterBinding.ensureInitialized();
    // 锁定竖屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //
    runApp(const AppLife(child: DefaultApp()));
  }
}
