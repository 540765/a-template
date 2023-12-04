import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoadingWidget {
  static Future<void> showLoading(
      {String msg = 'loading',
      Color? background,
      bool backDismiss = true}) async {
    SmartDialog.showLoading(
      msg: msg,
      backDismiss: backDismiss,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //loading animation
              CupertinoActivityIndicator(
                color: Colors.white,
                radius: 30.sp,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> dismissLoading() async {
    await SmartDialog.dismiss(
      status: SmartStatus.loading,
    );
  }
}
