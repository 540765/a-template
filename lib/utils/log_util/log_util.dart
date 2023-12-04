import 'package:flutter_template/utils/log_util/log_abstract.dart';
import 'package:flutter_template/utils/log_util/log_config.dart';
import 'package:flutter_template/utils/log_util/log_enum.dart';
import 'package:flutter_template/utils/log_util/log_manager.dart';
import 'package:flutter_template/utils/log_util/log_stack_formatter.dart';
import 'package:flutter_template/utils/log_util/log_stack_trace.dart';

class LogUtil {
  static const String _ignorePackageName = "log_demo/utils/log";

  static void V(
      {String? tag,
      dynamic message,
      LogConfig? logConfig,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.V,
        tag: tag ??= "",
        logConfig: logConfig,
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void E(
      {String? tag,
      dynamic message,
      LogConfig? logConfig,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.E,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static void I(
      {String? tag,
      dynamic message,
      LogConfig? logConfig,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.I,
        tag: tag ??= "",
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void D(
      {String? tag,
      dynamic message,
      LogConfig? logConfig,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.D,
        tag: tag ??= "",
        logConfig: logConfig,
        message: message,
        json: json,
        stackTrace: stackTrace);
  }

  static void A(
      {String? tag,
      LogConfig? logConfig,
      dynamic message,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.A,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static void W(
      {String? tag,
      dynamic message,
      LogConfig? logConfig,
      StackTrace? stackTrace,
      Map<String, dynamic>? json}) {
    _logPrint(
        type: LogType.W,
        tag: tag ??= "",
        message: message,
        logConfig: logConfig,
        json: json,
        stackTrace: stackTrace);
  }

  static Future<void> _logPrint({
    required LogType type,
    required String tag,
    LogConfig? logConfig,
    dynamic message,
    StackTrace? stackTrace,
    Map<String, dynamic>? json,
  }) async {
    ///如果logConfig为空那么就用默认的
    logConfig ??= LogManager().config;
    if (!logConfig?.enable) {
      return;
    }
    StringBuffer sb = StringBuffer();

    ///打印当前页面
    if (message.toString().isNotEmpty) {
      sb.write(message);
    }

    ///如果传入了栈且 要展示的深度大于0
    if (stackTrace != null && logConfig?.stackTraceDepth > 0) {
      sb.writeln();
      String stackTraceStr = StackFormatter().format(
          StackTraceUtil.getCroppedRealStackTrace(
              stackTrace: stackTrace,
              ignorePackage: _ignorePackageName,
              maxDepth: logConfig?.stackTraceDepth));
      sb.write(stackTraceStr);
    }
    if (json != null) {
      sb.writeln();
      String body = JsonFormatter().format(json);
      sb.write(body);
    }

    ///获取有几个打印器
    List<IHCLogPrint> prints = logConfig?.printers ?? LogManager().printers;
    if (prints.isEmpty) {
      return;
    }

    ///遍历打印器 分别打印数据
    for (IHCLogPrint print in prints) {
      print.logPrint(type: type, tag: tag, message: sb.toString());
    }
  }
}
