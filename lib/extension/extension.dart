import 'package:flutter/cupertino.dart';

/// 字符串扩展
extension StringExtension on String? {
  String get nullSafe => this ?? '';
}

/// 防止文字自动换行
/// 当中英文混合，或者中文与数字或者特殊符号，或则英文单词时，文本会被自动换行，
/// 这样会导致，换行时上一行可能会留很大的空白区域
/// 把每个字符插入一个0宽的字符， \u{200B}
extension FixAutoLines on String {
  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }
}

/// int 扩展
extension IntExtension on int? {
  int get nullSafe => this ?? 0;
}

/// double 扩展
extension DoubleExtension on double? {
  double get nullSafe => this ?? 0;
}

/// num 扩展
extension NumExtension on num? {
  num get nullSafe => this ?? 0;
}

/// Duration 扩展
extension DurationExtension on Duration {
  /// 将Duration转为 HH:mm:ss格式
  String toHHMMSSString() => toString().split('.').first.padLeft(8, "0");
}

/// 布尔类型 扩展
extension BoolExtension on bool? {
  bool get nullSafe => this ?? false;
}
