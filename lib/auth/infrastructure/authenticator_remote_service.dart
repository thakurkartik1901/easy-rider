import 'package:easy_rider/core/constants/analytics_event.dart';
import 'package:easy_rider/core/constants/app_apis.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/event_service.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:dio/dio.dart';

class AuthenticatorRemoteService {
  static final AuthenticatorRemoteService _singleton =
      AuthenticatorRemoteService._internal();

  factory AuthenticatorRemoteService() => _singleton;

  AuthenticatorRemoteService._internal();

  static final Dio _dio = Dio();
  Future<void> sendOTP(
    String phone,
  ) async {
    try {
      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.authSendOtp,
      // );

      // await _dio.postUri(
      //   requestUri,
      //   data: {
      //     'phoneNumber': phone,
      //   },
      //   options: Options(
      //     headers: {
      //       'Accept': 'application/json',
      //       'xxx-bgl-usr-typ': 'driver',
      //     },
      //     responseType: ResponseType.json,
      //   ),
      // );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOTP(String phone, String otp) async {
    try {
      final requestUri = Uri.https(
        AppApis.baseUrl,
        AppApis.authVerifyOtp,
      );

      // final response = await _dio.postUri(
      //   requestUri,
      //   data: {
      //     'phoneNumber': phone,
      //     'enteredOTP': otp,
      //   },
      //   options: Options(
      //     headers: {
      //       'Accept': 'application/json',
      //       'xxx-bgl-usr-typ': 'driver',
      //     },
      //     responseType: ResponseType.json,
      //   ),
      // );
      CacheService.put(
        AppConstants.sharedPreferenceAccessTokenKey,
        "dafsgsbcvsfsvfsbsfbsfdsdfss",
      );
      CacheService.put(
        AppConstants.sharedPreferenceRefreshTokenKey,
        "dafsgsbcvsfsvfsbsfbdfsdfdsfs",
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      // final refreshToken =
      //     CacheService.get(AppConstants.sharedPreferenceRefreshTokenKey);
      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.authRefreshToken,
      // );
      // final response = await _dio.postUri(
      //   requestUri,
      //   data: {
      //     'refreshToken': refreshToken,
      //   },
      //   options: Options(
      //     headers: {
      //       'Accept': 'application/json',
      //       'xxx-bgl-usr-typ': 'driver',
      //     },
      //     responseType: ResponseType.json,
      //   ),
      // );
      CacheService.put(
        AppConstants.sharedPreferenceAccessTokenKey,
        "dafsgsbcvsfsvfsbsfbsfdsdfss",
      );
      CacheService.put(
        AppConstants.sharedPreferenceRefreshTokenKey,
        "dafsgsbcvsfsvfsbsfbdfsdfdsfs",
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFcmToken(
    String fcmToken,
  ) async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.drUpdateFcmToken,
      // );

      // await _dio.putUri(
      //   requestUri,
      //   data: {'fcmToken': fcmToken},
      //   options: Options(
      //     headers: {
      //       'Authorization': 'Bearer $accessToken',
      //       'Accept': 'application/json',
      //     },
      //     responseType: ResponseType.json,
      //   ),
      // );
    } catch (e) {
      rethrow;
    }
  }
}
