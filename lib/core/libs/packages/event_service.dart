import 'package:firebase_analytics/firebase_analytics.dart';

class EventService {
  static final EventService _singleton = EventService._internal();

  EventService._internal();

  factory EventService() {
    return _singleton;
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static void logDefaultEventParameters({Map<String, Object?>? parameters}) {
    Map<String, Object>? nonNullableParameters;
    if (parameters != null) {
      nonNullableParameters = <String, Object>{};
      parameters.forEach((key, value) {
        if (value != null) {
          if (value is Map) {
            nonNullableParameters![key] = value.toString();
          } else {
            nonNullableParameters![key] = value;
          }
        }
      });
    }
    analytics.setDefaultEventParameters(nonNullableParameters);
  }

  static void logUser(String userId) {
    analytics.setUserId(id: userId);
  }

  static void log(String eventName, {Map<String, Object?>? parameters}) {
    Map<String, Object>? nonNullableParameters;
    if (parameters != null) {
      nonNullableParameters = <String, Object>{};
      parameters.forEach((key, value) {
        if (value != null) {
          if (value is Map) {
            nonNullableParameters![key] = value.toString();
          } else {
            nonNullableParameters![key] = value;
          }
        }
      });
    }
    final String name = eventName.replaceAll(" ", "_");
    analytics.logEvent(name: name, parameters: nonNullableParameters);
  }

  static void logCurrentScreen(String screenName) {
    final String name = screenName.replaceAll(" ", "_");
    analytics.setCurrentScreen(screenName: name);
  }

  void reset() {
    analytics.resetAnalyticsData();
  }
}
