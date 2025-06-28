package com.easyrider.rider

import io.flutter.app.FlutterApplication
import android.app.NotificationChannel
import android.app.NotificationManager
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import com.easyrider.rider.R

class Application : FlutterApplication() {
  override fun onCreate() {
    super.onCreate()
 
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val soundUri: Uri = Uri.parse(
              "android.resource://" +
                      applicationContext.packageName +
                      "/" +
                      R.raw.ride)

      val audioAttributes = AudioAttributes.Builder()
              .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
              .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
              .build()

      val channel = NotificationChannel("easyrider",
              "easyrider Notification",
              NotificationManager.IMPORTANCE_HIGH)
      channel.setSound(soundUri, audioAttributes)

      val notificationManager = getSystemService(NotificationManager::class.java)
      notificationManager.createNotificationChannel(channel)
    }
  }
}
