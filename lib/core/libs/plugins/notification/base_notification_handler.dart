import 'package:firebase_messaging/firebase_messaging.dart';

abstract class BaseNotificationHandler {
  void handleNotifications(RemoteMessage msg);
}
