import 'package:flutter_template/utils/log_util/log_enum.dart';

/// 日志打印输出的接口类
abstract class IHCLogPrint {
  void logPrint({
    required LogType type,
    required String tag,
    required String message,
    StackTrace? stackTrace,
    Map<String, dynamic>? json,
  });
}

///格式化的接口类
abstract class IHCLogFormatter<T> {
  String format(T data);
}
