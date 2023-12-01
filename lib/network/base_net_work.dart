import 'package:dio/dio.dart';

class BaseNetWork {
  // 工廠模式
  factory BaseNetWork() => _getInstance();

  static BaseNetWork get instance => _getInstance();

  static final BaseNetWork _instance = BaseNetWork._internal();

  late final Dio dio;
  BaseOptions? options;

  BaseNetWork._internal() {
    dio = Dio()
      ..options = BaseOptions(
        baseUrl: '',
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.plain,
      );
  }

  static BaseNetWork _getInstance() {
    return _instance;
  }
}
