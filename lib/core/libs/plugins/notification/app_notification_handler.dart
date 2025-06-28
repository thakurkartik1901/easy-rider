import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/core/libs/plugins/locator.dart';
import 'package:easy_rider/core/libs/plugins/navigation_service.dart';
import 'package:easy_rider/core/libs/plugins/notification/base_notification_handler.dart';
import 'package:easy_rider/core/libs/plugins/notification/sound_service.dart';
import 'package:easy_rider/core/libs/plugins/notification/ytts_utils.dart';
import 'package:easy_rider/core/presentation/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppNotificationHandler extends BaseNotificationHandler {
  AppNotificationHandler();

  @override
  void handleNotifications(RemoteMessage msg) {
    final RemoteNotification? notification = msg.notification;
    final data = msg.data;

    final String? bookingId =
        data['bookingId'] != null ? data['bookingId'] as String : null;
    // final String type = data["type"] as String ?? '';

    const String soundType = "en-IN";

    try {
      // type == NotificationType.RIDE
      if (bookingId != null) {
        if (notification?.title != null) {
          YTtsUtils.play(soundType, "${notification?.title}");
        }
        _openRide(bookingId);
      }

      SoundService.playSound(
        "assets/sounds/ride.mp3",
        withVibration: true,
        vibrationAmplitude: 255,
      );
    } on Exception catch (e, s) {}
  }

  void _openRide(String rideId) {
    CacheService.put(
      AppConstants.notificationRideKey,
      rideId,
    );
    locator<NavigationService>().navigateTo(AppRoutes.rideAlertScreen);
  }
}

class NotificationType {
  static const String RIDE = "RIDE";
}
