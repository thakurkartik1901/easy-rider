import 'dart:async';
import 'dart:ui';

// import 'package:easy_rider/core/libs/packages/firebase_remote_config_service.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/core/libs/plugins/location/location_service.dart';
import 'package:easy_rider/core/libs/plugins/locator.dart';
import 'package:easy_rider/core/libs/plugins/notification/app_notification_handler.dart';
import 'package:easy_rider/core/libs/plugins/notification/notification_service.dart';
import 'package:easy_rider/core/presentation/app_widget.dart';
import 'package:easy_rider/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
void main() => initMyapp();

Future<void> initMyapp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseRemoteConfigService().initialize();
  
  // Only initialize Firebase Crashlytics on mobile platforms
  if (!kIsWeb) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } else {
    // For web, use basic error handling
    FlutterError.onError = (errorDetails) {
      // Log to console for web
      print('Flutter Error: ${errorDetails.exception}');
      print('Stack trace: ${errorDetails.stack}');
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      // Log to console for web
      print('Platform Error: $error');
      print('Stack trace: $stack');
      return true;
    };
  }

  await CacheService.getInstance();
  setupLocator();
  NotificationService.init(AppNotificationHandler());
  
  // Only initialize background service on mobile platforms
  if (!kIsWeb) {
    await initializeService();
  }
  
  runApp(const AppWidget());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Only initialize notifications on mobile platforms
  if (!kIsWeb) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    final position = await LocationService().getCurrentPosition();

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'Easy Delivery App Service',
          'Loading...',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "Easy Delivery App Service",
          content: 'Location updated at ${DateTime.now()}',
        );
      }
    }

    /// you can see this log in logcat

    if (position != null) {
      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        },
      );
    }
  });
}

///ICON BUILDER COMMANDs
///flutter pub run flutter_launcher_icons:main
///
/// BUILD RUNNER COMMAND
/// flutter pub run build_runner watch --delete-conflicting-outputs

/// COMMAND BUILD APK
/// flutter build apk --target-platform=android-arm --split-per-abi

 
