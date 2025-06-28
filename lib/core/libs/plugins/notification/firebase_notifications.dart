import 'package:easy_rider/core/libs/plugins/notification/base_notification_handler.dart';
import 'package:easy_rider/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

BaseNotificationHandler? handler;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
  BaseNotificationHandler baseHandler,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Notification Received at _firebaseMessagingBackgroundHandler");
  await setupFlutterNotifications(baseHandler);
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications(
  BaseNotificationHandler baseHandler,
) async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  handler = baseHandler;
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // final NotificationSettings settings =
  await messaging.requestPermission();

  // print('User granted permission: ${settings.authorizationStatus}');

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(
  RemoteMessage message,
) {
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'logo', //'launch_background',
        ),
      ),
    );
  }
  if (message.data != null) {
    handler?.handleNotifications(message);
  }
}

class FirebaseNotifications {
  FirebaseNotifications._internal();

  static final FirebaseNotifications _instance =
      FirebaseNotifications._internal();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  factory FirebaseNotifications() {
    return _instance;
  }

  String? fcmToken;

  Future<String?> init() async {
    if (fcmToken != null) {
      return fcmToken;
    } else if (_firebaseMessaging != null) {
      try {
        fcmToken = await _firebaseMessaging
            .getToken()
            .timeout(const Duration(seconds: 2));
        print("Got Firebase token............${fcmToken}");
      } catch (exception) {
        fcmToken = await _firebaseMessaging.getToken();
        print("Got Firebase token in catch............");
      }
      return fcmToken;
    } else {
      print("Firebase token No Setup............");
      return null;
    }
  }

  Future<void> setNotification(BaseNotificationHandler baseHandler) async {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print("Notification Received at onBackgroundMessage");
      return _firebaseMessagingBackgroundHandler(message, baseHandler);
    });

    if (!kIsWeb) {
      await setupFlutterNotifications(baseHandler);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification Received at onMessage");
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification Received at onMessageOpenedApp");
      showFlutterNotification(message);
    });

    final RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print("Notification Received at getInitialMessage");
      showFlutterNotification(initialMessage);
    }
  }
}
