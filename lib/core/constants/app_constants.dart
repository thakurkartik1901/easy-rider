import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConstants {
  AppConstants._(); //this is to prevent anyone from instantiating this object
  // static const String baseUrl =
  //     'fb83-2401-4900-1c5d-79-d5c2-f448-ac-dfcf.ngrok.io';
  // static const String baseUrl = '10.0.2.2:8000';

  static final systemThemeLight = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  );
  static final systemThemeDark = SystemUiOverlayStyle.dark
      .copyWith(systemNavigationBarColor: AppConstants.primaryColor);

  static const List<Color> colors = Colors.primaries;

  static const double bottomsheetFull = 1;
  static const double bottomsheetFullAlmost = 0.93;
  static const double bottomsheetQarterFull = 0.75;
  static const double bottomsheetHalf = 0.5;
  static const double bottomsheetQarterHalf = 0.4;

  static const String loginProviderGoogle = 'google';
  static const String loginProviderEmail = 'email';
  static const String loginProviderFacebook = 'facebook';
  static const String loginProviderTwitter = 'twitter';
  static const String loginProviderTrueCaller = 'truecaller';

  //FontFamily Colors
  static const String fontFamilyNotoSans = 'NotoSans';
  static const String fontFamilyLora = 'Lora';

  //App Colors
  static const Color primaryColor = Color.fromARGB(255, 133, 220, 190);
  static const Color backgroundColor = Color.fromARGB(255, 62, 98, 222);
  static const Color buttonColor = Color.fromARGB(255, 62, 98, 222);
  static const Color buttonDisabled = Color.fromARGB(255, 149, 170, 246);
  static const Color lightGrey = Color.fromARGB(255, 236, 237, 242);
  static const Color buttonPrimary = Color.fromARGB(255, 62, 98, 222);
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color.fromARGB(255, 63, 63, 65);
  static const Color textSecondaryLight = Color.fromARGB(255, 185, 185, 186);
  static const Color borderColor = Color.fromARGB(255, 244, 244, 244);
  static const Color dividerColor = Color.fromARGB(255, 250, 250, 250);
  static const Color errorColor = Color.fromARGB(255, 251, 56, 56);
  static const Color onlineColor = Color.fromARGB(255, 3, 189, 6);

  //SHARED_PREFERENCE
  static const String sharedPreferenceAccessTokenKey =
      'SHARED_PREFERENCE_TOKEN_KEY';
  static const String sharedPreferenceRefreshTokenKey =
      'SHARED_PREFERENCE_REFRESH_TOKEN_KEY';

  static const String sharedPreferenceLanguageKey =
      'SHARED_PREFERENCE_LANGUAGE_KEY';

  static const String notificationRideKey = 'NOTIFICATION_RIDE_KEY';
}
