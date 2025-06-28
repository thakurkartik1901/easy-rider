import 'dart:async';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/widgets/overlays/toasts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();
  LocationService._internal();

  factory LocationService() {
    return _singleton;
  }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position?> getCurrentPosition({BuildContext? context}) async {
    final hasPermission = await handlePermission(context);

    if (!hasPermission) {
      return null;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  Future<bool> handlePermission(BuildContext? context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _showToast(
        message: "Location services are disabled. Can't mark online",
        context: context,
      );
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _showToast(
          message: "Allow permission to mark yourself online",
          context: context,
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _showToast(
        message: "Allow permission to mark yourself online",
        context: context,
      );
      _openAppSettings(context);
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }

  Future<void> _openAppSettings(BuildContext? context) async {
    await _geolocatorPlatform.openAppSettings().then((opened) {
      if (!opened) {
        _showToast(
          message: "Error opening Location Settings",
          context: context,
        );
      }
    });
  }

  void _showToast({
    String? message,
    ToastType toastType = ToastType.error,
    BuildContext? context,
  }) {
    if (context != null) {
      final labels = context.localizations;
      showToast(
        message ?? labels.errorMessage.somethingWrong,
        context,
        toastType: toastType,
      );
    }
  }
}
