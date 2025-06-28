import 'package:easy_rider/core/constants/app_apis.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/ride/model/data_ui.dart';
import 'package:dio/dio.dart';

class UserRemoteService {
  static final UserRemoteService _singleton = UserRemoteService._internal();

  factory UserRemoteService() => _singleton;

  UserRemoteService._internal();

  static final Dio _dio = Dio();

  Future<DataUI> fetchUser() async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.drProfile,
      // );
      // final response = await _dio.getUri(
      //   requestUri,
      //   options: Options(
      //     headers: {
      //       'Authorization': 'Bearer $accessToken',
      //       'Accept': 'application/json',
      //     },
      //     responseType: ResponseType.json,
      //   ),
      // );
      const resposne = {
        "min_version": "1.0.0",
        "max_version": "1.0.0",
        "driver": {
          "user": {"name": "Suresh Verma", "phoneNumber": "+91-5432109876"},
          "taxiService": "Easy Delivery Rider",
          "licenseNumber": "DL-05-2022-1122334",
          "profile_pic": "https://static.vecteezy.com/system/resources/thumbnails/028/719/517/small_2x/young-man-smiling-for-the-camera-standing-in-office-free-photo.jpg",
        },
        "cab": {
          "registrationNumber": "DL-05-IJ-7890",
          "model": "Mahindra XUV300",
          "make": "Mahindra",
          "year": 2023,
          "available": true,
        },
      };
      final DataUI dataui = DataUI.fromJson(resposne as Map<String, dynamic>);
      return dataui;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeDutyStatus(bool status) async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.drOnline,
      // );
      // await _dio.putUri(
      //   requestUri,
      //   data: {
      //     'available': status,
      //   },
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

  Future<void> syncUserLocation(double lat, double lng) async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.drUpdateCabLocation,
      // );
      // await _dio.putUri(
      //   requestUri,
      //   data: {
      //     "coordinates": [lng, lat],
      //   },
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
