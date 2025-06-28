import 'package:easy_rider/auth/infrastructure/authenticator_remote_service.dart';
import 'package:easy_rider/auth/model/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthenticatorRepository {
  static final AuthenticatorRepository _singleton =
      AuthenticatorRepository._internal();

  factory AuthenticatorRepository() => _singleton;

  AuthenticatorRepository._internal();

  final AuthenticatorRemoteService _authenticatorService =
      AuthenticatorRemoteService();

  Future<Either<AuthFailure, Unit>?> sendOTP(
    String phone,
  ) async {
    try {
      await _authenticatorService.sendOTP(phone);
      return right(unit);
    } on DioError catch (e) {
      return left(AuthFailure.server);
    }
  }

  Future<Either<AuthFailure, Unit>?> verifyOTP(String phone, String otp) async {
    try {
      await _authenticatorService.verifyOTP(phone, otp);
      return right(unit);
    } on DioError catch (e) {
      AuthFailure authFailure = AuthFailure.server;
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        switch (e.response!.data['message']) {
          case "invalid otp":
            authFailure = AuthFailure.invalidCredential;
            break;
          default:
            authFailure = AuthFailure.server;
        }
      }
      return left(authFailure);
    }
  }

  Future<Either<AuthFailure, Unit>?> refreshToken() async {
    try {
      await _authenticatorService.refreshToken();
      return right(unit);
    } on DioError catch (e) {
      return left(AuthFailure.server);
    }
  }

  Future<Either<AuthFailure, Unit>?> updateFcmToken(String fcmToken) async {
    try {
      await _authenticatorService.updateFcmToken(fcmToken);
      return right(unit);
    } on DioError catch (e) {
      return left(AuthFailure.server);
    }
  }
}
