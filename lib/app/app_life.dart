import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class AppLife extends StatefulWidget {
  const AppLife({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => AppLifeState();
}

class AppLifeState extends State<AppLife> with WidgetsBindingObserver {
  late AppLifecycleState appLifecycleState;
  late ConnectivityResult connectivityResult;
  // 消息订阅
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this); //生命周期观察👀
    setState(() {
      //主动获取生命周期
      appLifecycleState =
          WidgetsBinding.instance.lifecycleState ?? AppLifecycleState.resumed;
      //初始化网络状态
      Connectivity().checkConnectivity().then((value) {
        connectivityResult = value;
      });
      //网络状态监听
      subscription = Connectivity().onConnectivityChanged.listen((result) {
        if (result == ConnectivityResult.mobile) {
          connectivityResult = ConnectivityResult.mobile;
        } else if (result == ConnectivityResult.wifi) {
          connectivityResult = ConnectivityResult.wifi;
        } else if (result == ConnectivityResult.ethernet) {
          connectivityResult = ConnectivityResult.ethernet;
        } else if (result == ConnectivityResult.vpn) {
          connectivityResult = ConnectivityResult.vpn;
        } else if (result == ConnectivityResult.bluetooth) {
          connectivityResult = ConnectivityResult.bluetooth;
        } else if (result == ConnectivityResult.other) {
          connectivityResult = ConnectivityResult.other;
        } else if (result == ConnectivityResult.none) {
          connectivityResult = ConnectivityResult.none;
        }
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      appLifecycleState = state;
    });
    //生命周期回调
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 移除观察者👀
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
