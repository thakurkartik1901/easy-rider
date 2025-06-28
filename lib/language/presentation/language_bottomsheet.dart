import 'package:easy_rider/language/presentation/language_selector.dart';
import 'package:flutter/material.dart';

class LanguageBottomsheet {
  LanguageBottomsheet._();

  static Future<void> openBottonSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 600),
      builder: (context) {
        return const FractionallySizedBox(
          heightFactor: 0.25,
          child: LanguageSelector(),
        );
      },
    );
  }
}
