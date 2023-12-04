import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  /// 內部構造方法，可避免外部暴露構造函數，進行實例化
  SPUtil._internal();

  static SharedPreferences? _spf;

  static Future<SharedPreferences> init() async {
    _spf ??= await SharedPreferences.getInstance();
    return _spf!;
  }

  //清除所有
  static Future<bool> clearAll() async {
    return await _spf!.clear();
  }
}
