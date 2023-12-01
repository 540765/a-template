import 'package:flutter_template/page/splash/splash_binding.dart';
import 'package:flutter_template/page/splash/splash_view.dart';
import 'package:flutter_template/routes/routes.dart';
import 'package:get/get.dart';

class RoutePages {
  RoutePages._();
  static const initialRouter = Routes.splash;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      middlewares: null,
    ),
  ];
}
