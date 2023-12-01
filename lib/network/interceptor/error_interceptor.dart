import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionError:
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        break;
      case DioExceptionType.badResponse:
        break;
      case DioExceptionType.connectionTimeout:
        break;
      case DioExceptionType.receiveTimeout:
        break;
      case DioExceptionType.sendTimeout:
        break;
      case DioExceptionType.unknown:
        break;
      default:
        {
          //其他错误
        }
    }
    handler.next(err);
  }
}
