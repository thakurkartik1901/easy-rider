import 'package:easy_rider/auth/presentation/log_in_page.dart';
import 'package:easy_rider/home/presentation/home_page.dart';
import 'package:easy_rider/location/presentation/location_page.dart';
import 'package:easy_rider/ride/presentation/ride_alert_page.dart';
import 'package:easy_rider/splash/presentation/splash_page.dart';
import 'package:easy_rider/web/presentation/web_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static const String splashScreen = '/splash';
  static const String locationScreen = '/location';
  static const String authenticationScreen = '/log-in';
  static const String homeScreen = '/home';
  static const String webScreen = '/web';
  static const String rideAlertScreen = '/alert';

  static final routes = <String, WidgetBuilder>{
    splashScreen: (BuildContext context) => const SplashPage(),
    locationScreen: (BuildContext context) => const LocationPage(),
    authenticationScreen: (BuildContext context) => const LogInPage(),
    homeScreen: (BuildContext context) => const HomePage(),
    webScreen: (BuildContext context) => const WebPage(),
    rideAlertScreen: (BuildContext context) => const RideAlertPage(),
  };
}
