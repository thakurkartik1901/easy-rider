import 'package:easy_rider/auth/infrastructure/authenticator_repository.dart';
import 'package:easy_rider/auth/model/auth_failure.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/packages/localizations.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/core/libs/plugins/notification/firebase_notifications.dart';
import 'package:easy_rider/core/presentation/widgets/overlays/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum AuthState {
  initial,
  unauthenticated,
  authenticated,
  otpSent,
  otpSentfailure,
  otpVerifyfailure,
  failure
}

enum ApiState { initial, inprogress, success, failure }

class AuthNotifier with ChangeNotifier {
  AuthNotifier();
  static final AuthenticatorRepository _authenticatorRepository =
      AuthenticatorRepository();

  AuthState authState = AuthState.initial;

  Future<String?> getSignedInCredentials(BuildContext context) async {
    try {
      final accessToken =
          CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);
      final refreshToken =
          CacheService.get(AppConstants.sharedPreferenceRefreshTokenKey);

      if (accessToken == null ||
          refreshToken == null ||
          accessToken == '' ||
          refreshToken == '' ||
          JwtDecoder.isExpired(refreshToken)) {
        clearCredentialsStorage();
        return null;
      } else if (JwtDecoder.isExpired(accessToken)) {
        authState = await refreshTokenCall();
        if (authState == AuthState.unauthenticated ||
            authState == AuthState.failure) {
          clearCredentialsStorage();
          return null;
        }
      } else {
        authState = AuthState.authenticated;
      }
      if (authState == AuthState.authenticated) {
        updateFcmToken(context);
      }
      return accessToken;
    } on PlatformException {
      return null;
    }
  }

  Future<bool> isSignedIn(BuildContext context) async {
    final String? credentials = await getSignedInCredentials(context);
    if (credentials != null && credentials != '') {
      return true;
    }
    return false;
  }

  Future<void> sendOTP(
    String phone,
    BuildContext context,
  ) async {
    final failureOrSuccess = await _authenticatorRepository.sendOTP(phone);
    authState = failureOrSuccess!.fold(
      (l) {
        _showToast(context);
        return AuthState.otpSentfailure;
      },
      (r) {
        final labels = context.localizations;
        _showToast(
          context,
          message: labels.successMessage.otpSuccessful,
          toastType: ToastType.success,
        );
        return AuthState.otpSent;
      },
    );

    notifyListeners();
  }

  Future<AuthState> verifyOTP(
    String phone,
    String otp,
    BuildContext context,
  ) async {
    final failureOrSuccess =
        await _authenticatorRepository.verifyOTP(phone, otp);
    return authState = failureOrSuccess!.fold(
      (l) {
        final labels = context.localizations;
        switch (l) {
          case AuthFailure.server:
            _showToast(context);
          case AuthFailure.invalidCredential:
            _showToast(context, message: labels.errorMessage.invalidOTP);
          default:
        }
        return AuthState.otpVerifyfailure;
      },
      (r) {
        updateFcmToken(context);
        return AuthState.authenticated;
      },
    );
  }

  Future<AuthState> refreshTokenCall() async {
    final failureOrSuccess = await _authenticatorRepository.refreshToken();
    return authState = failureOrSuccess!.fold(
      (l) {
        return AuthState.failure;
      },
      (r) {
        return AuthState.authenticated;
      },
    );
  }

  void updateFcmToken(BuildContext context) {
    FirebaseNotifications().init().then((fcmToken) {
      if (fcmToken == null) {
        return;
      }
      _authenticatorRepository.updateFcmToken(fcmToken);
    });
  }

  Future<bool> clearCredentialsStorage() async {
    try {
      CacheService.clearKeys([
        AppConstants.sharedPreferenceAccessTokenKey,
        AppConstants.sharedPreferenceRefreshTokenKey,
      ]);
      return true;
    } on PlatformException {
      return false;
    }
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
