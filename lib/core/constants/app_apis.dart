class AppApis {
  AppApis._();

  static const String baseUrl = 'api.company.tech';

  // Auth Apis
  static const String authSendOtp = '/auth/sendOtp';
  static const String authVerifyOtp = '/auth/verifyOtp';
  static const String authRefreshToken = 'auth/refreshToken';
  static const String authSignOut = 'auth/signOut';

  // Driver Apis
  static const String drProfile = '/dr/profile';
  static const String drUpdateFcmToken = '/dr/updateFcmToken';
  static const String drActiveRides = '/dr/bookings/active';
  static const String drCompletedRides = 'dr/bookings/completed';
  static const String drStartTrip = '/dr/checkin';
  static const String drEndTrip = '/dr/endTrip';
  static const String drUpdateCabLocation = '/dr/updateCabLocation';
  static const String drOnline = '/dr/online';
}
