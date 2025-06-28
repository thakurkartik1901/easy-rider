import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:easy_rider/ride/presentation/ride_alert_page.dart';
import 'package:easy_rider/splash/presentation/splash_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static final RouteGenerator _singleton = RouteGenerator._internal();
  RouteGenerator._internal();

  factory RouteGenerator() {
    return _singleton;
  }
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Map<String, dynamic>? args = settings.arguments != null
        ? settings.arguments! as Map<String, dynamic>
        : null;
    final Route<dynamic> route;

    if (settings.name == AppRoutes.rideAlertScreen) {
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) => const RideAlertPage(),
      );
    } else if (settings.name == AppRoutes.splashScreen) {
      return MaterialPageRoute(
        builder: (_) => const SplashPage(),
      );
    }
  }
}
