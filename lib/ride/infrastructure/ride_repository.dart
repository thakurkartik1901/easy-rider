import 'package:easy_rider/core/model/api_failure.dart';
import 'package:easy_rider/ride/infrastructure/ride_remote_service.dart';
import 'package:easy_rider/ride/model/data_ui.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:easy_rider/ride/model/ride_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RideRepository {
  static final RideRemoteService _remoteService = RideRemoteService();

  RideRepository();

  Future<Either<ApiFailure, List<Ride>>> fetchActiveRides() async {
    try {
      final List<Ride> rides = await _remoteService.fetchActiveRides();
      return right(rides);
    } catch (e) {
      return left(ApiFailure(errorCode: 500));
    }
  }

  Future<Either<ApiFailure, List<Ride>>> fetchCompletedRides(
      int page, int perPage) async {
    try {
      final List<Ride> rides =
          await _remoteService.fetchCompletedRides(page, perPage);
      return right(rides);
    } catch (e) {
      return left(ApiFailure(errorCode: 500));
    }
  }

  Future<Either<RideFailure, Unit>?> startRide(
    String rideId,
    String otp,
  ) async {
    try {
      await _remoteService.startRide(rideId, otp);
      return right(unit);
    } on DioError catch (e) {
      RideFailure rideFailure = RideFailure.server;
      if (e.response != null &&
          e.response!.data != null &&
          (e.response!.data == "" || e.response!.data['message'] != null)) {
        if (e.response!.data == "") {
          rideFailure = RideFailure.server;
        } else {
          switch (e.response!.data['message']) {
            case "invalid otp":
              rideFailure = RideFailure.invalidCredential;
              break;
            default:
              rideFailure = RideFailure.server;
          }
        }
      }
      return left(rideFailure);
    }
  }

  Future<Either<RideFailure, Unit>?> endRide(String rideId) async {
    try {
      await _remoteService.endRide(rideId);
      return right(unit);
    } on DioError catch (e) {
      return left(RideFailure.server);
    }
  }
}
