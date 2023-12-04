import 'package:flutter_template/utils/log_util/log_abstract.dart';

//堆栈格式化
class StackFormatter implements IHCLogFormatter<List<String>> {
  @override
  String format(List<String> stackList) {
    ///每一行都设置成单独的 字符串
    StringBuffer sb = StringBuffer();

    ///堆栈是空的直接返回
    if (stackList.isEmpty) {
      return "";

      ///堆栈只有一行那么就返回 - 堆栈
    } else if (stackList.length == 1) {
      return "\n\t-${stackList[0].toString()}\n";

      ///多行堆栈格式化
    } else {
      for (int i = 0; i < stackList.length; i++) {
        if (i == 0) {
          sb.writeln("\n\t┌StackTrace:");
        }
        if (i != stackList.length - 1) {
          sb.writeln("\t├${stackList[i].toString()}");
        } else {
          sb.write("\t└${stackList[i].toString()}");
        }
      }
    }
    return sb.toString();
  }
}

//json格式化
class JsonFormatter extends IHCLogFormatter<Map<String, dynamic>> {
  @override
  String format(Map<String, dynamic> data) {
    ///递归调用循环遍历data 在StringBuffer中添加StringBuffer
    String finalString = _forEachJson(data, 0);
    finalString = "\ndata:$finalString";
    return finalString;
  }

  /// [data]  传入需要格式化的数据
  /// [spaceCount]  需要添加空格的长度 一个数字是两个空格
  /// [needSpace] 需不需要添加空格
  /// [needEnter] 需不需要回车
  String _forEachJson(dynamic data, int spaceCount,
      {bool needSpace = true, needEnter = true}) {
    StringBuffer sb = StringBuffer();
    int newSpace = spaceCount + 1;
    if (data is Map) {
      ///如果它是Map走这里
      ///是否需要空格
      sb.write(buildSpace(needSpace ? spaceCount : 0));
      sb.write(needEnter ? "{\n" : "{");
      data.forEach((key, value) {
        ///打印输出 key
        sb.write("${buildSpace(needEnter ? newSpace : 0)}$key: ");

        ///递归调用看value是什么类型 如果字符长度少于30就不回车显示
        sb.write(_forEachJson(value, newSpace,
            needSpace: false,
            needEnter: !(value is Map ? false : value.toString().length < 50)));

        ///不是最后一个就加,
        if (data.keys.last != key) {
          sb.write(needEnter ? ",\n" : ",");
        }
      });
      if (needEnter) {
        sb.writeln();
      }
      sb.write("${buildSpace(needEnter ? spaceCount : 0)}}");
    } else if (data is List) {
      ///如果他是列表 走这里
      sb.write(buildSpace(needSpace ? spaceCount : 0));
      sb.write("[${needEnter ? "\n" : ""}");
      for (var item in data) {
        sb.write(_forEachJson(item, newSpace,
            needEnter: !(item.toString().length < 30)));

        ///不是最后一个就加的,
        if (data.last != item) {
          sb.write(needEnter ? ",\n" : ",");
        }
      }
      sb.write(needEnter ? "\n" : "");
      sb.write("${buildSpace(needSpace ? spaceCount : 0)}]");
    } else if (data is num || data is bool) {
      ///bool 或者数组不加双引号
      sb.write(data);
    } else if (data is String) {
      ///string 或者其他的打印加双引号 如果他是回车就改变他 按回车分行会错乱
      sb.write("\"${data.replaceAll("\n", r"\n")}\"");
    } else {
      sb.write("$data");
    }
    return sb.toString();
  }

  ///构造空格
  String buildSpace(int deep) {
    String temp = "";
    for (int i = 0; i < deep; i++) {
      temp += "  ";
    }
    return temp;
  }
}
