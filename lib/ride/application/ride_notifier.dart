import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/presentation/widgets/overlays/toasts.dart';
import 'package:easy_rider/ride/infrastructure/ride_repository.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:easy_rider/ride/model/ride_failure.dart';
import 'package:flutter/material.dart';

enum RideState { initial, inProgress, success, failure }

enum RideStatusUpdate { initial, otpVerifyfailure, failure, success }

class RideValueNotifier with ChangeNotifier {
  RideValueNotifier();

  static final RideRepository _rideRepository = RideRepository();
  RideState rideState = RideState.initial;
  RideStatusUpdate rideStatusUpdateState = RideStatusUpdate.initial;

  // List<Ride> activeRides = (Stubs.rides as List<dynamic>)
  //     .map((e) => Ride.fromJson(e as Map<String, dynamic>))
  //     .toList();
  List<Ride> activeRides = [];
  List<Ride> completedRides = [];

  int page = 1;
  int perPage = 10;

  Future<void> fetchActiveRides() async {
    rideState = RideState.inProgress;
    if (activeRides.isEmpty) {
      notifyListener();
    }

    final successOrFailure = await _rideRepository.fetchActiveRides();
    rideState = successOrFailure.fold(
      (l) => RideState.failure,
      (r) {
        activeRides = r;
        return RideState.success;
      },
    );

    notifyListener();
  }

  Future<void> fetchCompletedRides({bool hardRefresh = false}) async {
    if (rideState == RideState.inProgress) {
      return;
    }
    rideState = RideState.inProgress;
    if (completedRides.isEmpty) {
      notifyListener();
    }

    if (hardRefresh) {
      page = 1;
    } else {
      page = page + 1;
    }

    final successOrFailure =
        await _rideRepository.fetchCompletedRides(page, perPage);
    rideState = successOrFailure.fold(
      (l) {
        if (page > 1) {
          page = page - 1;
        }
        return RideState.failure;
      },
      (r) {
        completedRides = r;
        return RideState.success;
      },
    );

    notifyListener();
  }

  Future<RideStatusUpdate> startRide(
    String rideId,
    String otp,
    BuildContext context,
  ) async {
    final failureOrSuccess = await _rideRepository.startRide(rideId, otp);
    return rideStatusUpdateState = failureOrSuccess!.fold(
      (l) {
        final labels = context.localizations;
        switch (l) {
          case RideFailure.server:
            _showToast(context);
          case RideFailure.invalidCredential:
            _showToast(context, message: labels.errorMessage.invalidOTP);
          default:
        }
        return RideStatusUpdate.otpVerifyfailure;
      },
      (r) {
        return RideStatusUpdate.success;
      },
    );
  }

  Future<RideStatusUpdate> endRide(
    String rideId,
    BuildContext context,
  ) async {
    final failureOrSuccess = await _rideRepository.endRide(rideId);
    return rideStatusUpdateState = failureOrSuccess!.fold(
      (l) {
        _showToast(context);
        return RideStatusUpdate.otpVerifyfailure;
      },
      (r) {
        return RideStatusUpdate.success;
      },
    );
  }

  void updateRidesData(Ride ride) {
    activeRides.removeWhere((item) => item.id == ride.id);
    completedRides = [ride, ...completedRides];

    rideStatusUpdateState = RideStatusUpdate.initial;
    notifyListener();
  }

  void notifyListener() {
    notifyListeners();
  }

  void _showToast(
    BuildContext context, {
    String? message,
    ToastType toastType = ToastType.error,
  }) {
    final labels = context.localizations;
    showToast(
      message ?? labels.errorMessage.somethingWrong,
      context,
      toastType: toastType,
    );
  }
}
