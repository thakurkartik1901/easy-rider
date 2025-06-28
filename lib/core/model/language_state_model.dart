import 'package:flutter/material.dart';

// Model class to hold menu option data (language and theme)
class LanguageState {
  String currentLanguage;
  Locale locale;

  LanguageState({this.currentLanguage = 'en', required this.locale});
}
