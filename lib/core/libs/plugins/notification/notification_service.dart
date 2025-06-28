import 'package:easy_rider/core/libs/plugins/notification/base_notification_handler.dart';
import 'package:easy_rider/core/libs/plugins/notification/firebase_notifications.dart';

class NotificationService {
  NotificationService._internal();

  static Future<void> init(BaseNotificationHandler handler) async {
    await FirebaseNotifications().setNotification(handler);
  }
}
