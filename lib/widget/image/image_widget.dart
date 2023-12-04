import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/file_util/file_util.dart';
import 'package:path/path.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key, required this.path});

  final String path;
  @override
  State<StatefulWidget> createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  //判断是否本地文件路径
  bool isLocalFile = false;

  @override
  void initState() {
    checkPath();
    super.initState();
  }

  //判断
  Future<void> checkPath() async {
    bool res = await FileUtil.checkFileExists(file: File(widget.path));
    setState(() {
      isLocalFile = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    //判断是assets资源
    bool isResource = isRelative(widget.path);
    //判断是否网络图片
    bool isNetWorkResource = widget.path.startsWith('http');
    //判断是否本地assets
    bool isAssetsResource = isResource && widget.path.contains('assets');

    if (isAssetsResource) {
      return ExtendedImage.asset(
        widget.path,
      );
    }
    if (isNetWorkResource) {
      return ExtendedImage.network(
        withoutExtension(
          widget.path,
        ),
      );
    }
    if (isLocalFile) {
      return ExtendedImage.file(
        File(
          widget.path,
        ),
      );
    }
    //到了这里肯定是不存在的文件了
    return ExtendedImage.asset(
      widget.path,
    );
  }
}
