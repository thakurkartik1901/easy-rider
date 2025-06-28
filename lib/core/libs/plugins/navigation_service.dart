import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _singleton = NavigationService._internal();
  NavigationService._internal();

  factory NavigationService() {
    return _singleton;
  }

  final GlobalKey<NavigatorState> yNavigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToReplacement(String _routeName) {
    return yNavigatorKey.currentState!.pushReplacementNamed(_routeName);
  }

  Future<dynamic> navigateAndRemoveUntil(String _routeName) {
    return yNavigatorKey.currentState!
        .pushNamedAndRemoveUntil(_routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> navigateToRoute(MaterialPageRoute _route) {
    return yNavigatorKey.currentState!.push(_route);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return yNavigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacementWithArgs(String routeName,
      {dynamic arguments}) {
    return yNavigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  goBack() {
    return yNavigatorKey.currentState?.pop();
  }
}
