import 'package:flutter/material.dart';

Future<void> showLoader(BuildContext context) async {
  Future.delayed(
    const Duration(milliseconds: 300),
  ).then(
    (value) => showGeneralDialog(
      context: context,
      barrierColor: Colors.white60,
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        );
      },
    ),
  );
}
