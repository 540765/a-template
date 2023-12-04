import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({
    super.key,
    required this.easyRefreshController,
    this.onLoad,
    this.onRefresh,
    this.childBuilder,
  });

  // EasyRefreshController实例，用于控制刷新和加载的状态
  final EasyRefreshController? easyRefreshController;

  // 加载回调函数
  final FutureOr<dynamic> Function()? onLoad;

  // 刷新回调函数
  final FutureOr<dynamic> Function()? onRefresh;

  // 构建子组件的回调函数
  final Widget Function(BuildContext context, ScrollPhysics physics)?
      childBuilder;

  @override
  State<StatefulWidget> createState() => RefreshWidgetState();
}

class RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      childBuilder: widget.childBuilder,
    );
  }
}
