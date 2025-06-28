import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
//
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/core/model/language_state_model.dart';
import 'package:easy_rider/core/model/menu_option_model.dart';
import 'package:flutter/material.dart';

final List<MenuOptionsModel> languageOptions = [
  MenuOptionsModel(
    key: "en",
    value: "English",
  ), //English ---- ok
  MenuOptionsModel(
    key: "hi",
    value: "हिन्दी (Hindi)",
  ), //Hindi ---- ok
  // MenuOptionsModel(
  //   key: "de",
  //   value: "Deutsche (German)",
  //   description: AppConstants.quotesListde[0],
  // ), //German---- ok
  // MenuOptionsModel(
  //   key: "es",
  //   value: "Español (Spanish)",
  //   description: AppConstants.quotesListes[0],
  // ), //Spanish---- ok
  // MenuOptionsModel(
  //   key: "fr",
  //   value: "Français (French)",
  //   description: AppConstants.quotesListfr[0],
  // ), //French---- ok
  // MenuOptionsModel(
  //   key: "pt",
  //   value: "Português (Portuguese)",
  //   description: AppConstants.quotesListpt[0],
  // ), //Portuguese---- ok
  // MenuOptionsModel(
  //   key: "ru",
  //   value: "русский (Russian)",
  //   description: AppConstants.quotesListru[0],
  // ), //Russian---- ok
  // MenuOptionsModel(key: "ja", value: "日本語 (Japanese)"), //Japanese---- no
  // MenuOptionsModel(key: "zh", value: "中文 (Chinese)"), //Chinese---- no
  // MenuOptionsModel(key: "ta", value: "தமிழ் (Tamil)"), //Tamil---- no
  // MenuOptionsModel(key: "bn", value: "বাংলা (Bengali)"), //Bengali---- no
  // MenuOptionsModel(key: "gu", value: "પસાર (Gujrati)"), //Gujrati---- no
  // MenuOptionsModel(key: "ko", value: "한국인 (Korean)"), //Korean---- no
  // MenuOptionsModel(key: "ar", value: "عربي (Arabic)"), //Arabic---- no
];

class LanguageNotifier with ChangeNotifier {
  LanguageNotifier();

  LanguageState languageState =
      LanguageState(locale: localizedLabels.keys.first);

  Locale getLocale() {
    final appCurrentLanguage =
        CacheService.get(AppConstants.sharedPreferenceLanguageKey) ?? "en";

    for (final locale in localizedLabels.keys) {
      if (locale.languageCode == appCurrentLanguage) {
        languageState = LanguageState(
          currentLanguage: appCurrentLanguage,
          locale: locale,
        );
      }
    }
    return languageState.locale;
  }

  void updateLanguage(String selectedLanguage) {
    CacheService.put(
      AppConstants.sharedPreferenceLanguageKey,
      selectedLanguage,
    );
    for (final locale in localizedLabels.keys) {
      if (locale.languageCode == selectedLanguage) {
        languageState = LanguageState(
          currentLanguage: selectedLanguage,
          locale: locale,
        );
      }
    }
    notifyListeners();
  }
}
