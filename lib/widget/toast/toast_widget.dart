import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

int lastClickTime = 0;

class ToastWidget {
  static Future<void> showToast(String? msg, {Alignment? alignment}) async {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (lastClickTime == 0 || currentTime - lastClickTime > 1000) {
      SmartDialog.showToast(msg ?? "msg",
          animationTime: const Duration(milliseconds: 500),
          alignment: alignment ?? Alignment.center, builder: (_) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$msg',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      });
      lastClickTime = currentTime;
    }
  }

  static Future<void> dismissToase() async {
    lastClickTime = 0;
    SmartDialog.dismiss(
      status: SmartStatus.toast,
    );
  }
}
