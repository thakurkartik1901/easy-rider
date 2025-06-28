import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

Future<void> showToast(
  String message,
  BuildContext context, {
  ToastType toastType = ToastType.error,
}) async {
  Color getBackgroundColor() {
    Color? backgroundColor = Colors.red.withOpacity(0.9);
    switch (toastType) {
      case ToastType.success:
        backgroundColor = Colors.green.withOpacity(0.8);
        break;
      case ToastType.warning:
        backgroundColor = Colors.orange.withOpacity(0.8);
        break;
      default:
    }
    return backgroundColor;
  }

  Future.delayed(
    const Duration(milliseconds: 300),
  ).then(
    (value) => showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          backgroundColor: getBackgroundColor(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(),
          ),
          behavior: FlashBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          position: FlashPosition.top,
          padding: const EdgeInsets.all(8.0),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        );
      },
    ),
  );
}

enum ToastType { success, error, warning }
