import 'package:easy_rider/core/model/api_failure.dart';
import 'package:easy_rider/home/infrastructure/user_remote_service.dart';
import 'package:easy_rider/ride/model/data_ui.dart';
import 'package:dartz/dartz.dart';

class UserRepository {
  static final UserRemoteService _remoteService = UserRemoteService();

  UserRepository();

  Future<Either<ApiFailure, DataUI>> fetchUser() async {
    try {
      final DataUI user = await _remoteService.fetchUser();
      return right(user);
    } catch (e) {
      return left(ApiFailure(errorCode: 500));
    }
  }

  Future<Either<ApiFailure, Unit>> changeDutyStatus(bool status) async {
    try {
      await _remoteService.changeDutyStatus(status);
      return right(unit);
    } catch (e) {
      return left(ApiFailure(errorCode: 500));
    }
  }

  Future<Either<ApiFailure, Unit>> syncUserLocation(
    double lat,
    double lng,
  ) async {
    try {
      await _remoteService.syncUserLocation(lat, lng);
      return right(unit);
    } catch (e) {
      return left(ApiFailure(errorCode: 500));
    }
  }
}
