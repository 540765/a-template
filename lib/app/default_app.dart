import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_template/routes/pages.dart';
import 'package:get/get.dart';

class DefaultApp extends StatelessWidget {
  const DefaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (ctx, child) {
          return GetMaterialApp(
            initialRoute: RoutePages.initialRouter,
            getPages: RoutePages.routes,
            navigatorObservers: [],
            routingCallback: (value) => {},
            builder: FlutterSmartDialog.init(builder: (ctx, child) {
              return MediaQuery(
                data: MediaQuery.of(ctx),
                child: Scaffold(
                  body: GestureDetector(
                    onTap: () {},
                    child: child,
                  ),
                ),
              );
            }),
          );
        });
  }
}
