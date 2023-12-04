import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class DialogWidget {
  static Future<void> showDialog({
    String title = "一級標題",
    String? tag,
    String? subTitle,
    String? cancelText,
    String? confirmText,
    bool showCancel = false,
    GestureTapCallback? onCancel,
    GestureTapCallback? onConfirm,
    double? width,
    double? height,
  }) async {
    SmartDialog.show(
      tag: tag,
      clickMaskDismiss: false,
      backDismiss: false,
      maskColor: const Color(0xff000000).withOpacity(0.7),
      builder: (BuildContext context) {
        return Container(
          width: width ?? 270.w,
          height: height ?? 140.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
        );
      },
    );
  }

  static Future<void> dismissDialog({String? tag}) async {
    await SmartDialog.dismiss(
      tag: tag,
      status: SmartStatus.dialog,
    );
  }
}
