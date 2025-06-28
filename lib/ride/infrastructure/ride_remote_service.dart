import 'package:easy_rider/core/constants/app_apis.dart';
import 'package:easy_rider/core/constants/app_constants.dart';
import 'package:easy_rider/core/libs/plugins/cache_service.dart';
import 'package:easy_rider/ride/model/ride.dart';
import 'package:dio/dio.dart';

class RideRemoteService {
  static final RideRemoteService _singleton = RideRemoteService._internal();

  factory RideRemoteService() => _singleton;

  RideRemoteService._internal();

  static final Dio _dio = Dio();

  Future<List<Ride>> fetchActiveRides() async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   AppApis.drActiveRides,
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

      const activeBooking = [
  {
    "_id": "ride_004",
    "customer": { "name": "Meera Kapoor", "phoneNumber": "+91-1098765432" },
    "pickupLocation": {
      "address": "Gate No. 2, Janpath Metro Station, Janpath Road, Connaught Place, New Delhi, Delhi 110001",
      "pincode": "110001",
      "coordinates": [77.2090, 28.6139]
    },
    "dropoffLocation": {
      "address": "Main Entrance, Humayun's Tomb Complex, Mathura Road, Nizamuddin East, New Delhi, Delhi 110013",
      "pincode": "110013",
      "coordinates": [77.2508, 28.5931]
    },
    "pickupTime": "2024-01-15T13:00:00.000Z",
    "startTime": null,
    "endTime": null,
    "status": "On Hold"
  },
  {
    "_id": "ride_005",
    "customer": { "name": "Arjun Reddy", "phoneNumber": "+91-0987654321" },
    "pickupLocation": {
      "address": "Exit Gate 5, Kashmere Gate Metro Station, Lala Hardev Sahai Marg, Mori Gate, New Delhi, Delhi 110006",
      "pincode": "110006",
      "coordinates": [77.2315, 28.6562]
    },
    "dropoffLocation": {
      "address": "Gate No. 3, Jama Masjid, Meena Bazaar, Jama Masjid Road, Chandni Chowk, Delhi 110006",
      "pincode": "110006",
      "coordinates": [77.2339, 28.6506]
    },
    "pickupTime": "2024-01-15T14:00:00.000Z",
    "startTime": "2024-01-15T14:05:00.000Z",
    "endTime": null,
    "status": "Checked-In"
  }
]
;

      final convertedData = (activeBooking as List<dynamic>)
          .map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Ride>> fetchCompletedRides(int page, int perPage) async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(AppApis.baseUrl, AppApis.drCompletedRides, {
      //   'page': '$page',
      //   'perPage': '$perPage',
      // });
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

      const bookings = [
        {
          "_id": "ride_106",
          "customer": {"name": "Pooja Sharma", "phoneNumber": "+91-9876543211"},
          "pickupLocation": {
            "address": "South Extension Market, New Delhi",
            "pincode": "110049",
            "coordinates": [77.2437, 28.5671],
          },
          "dropoffLocation": {
            "address": "Lodhi Garden, New Delhi",
            "pincode": "110003",
            "coordinates": [77.2276, 28.6002],
          },
          "pickupTime": "2024-01-14T10:00:00.000Z",
          "startTime": null,
          "endTime": null,
          "status": "No-Show",
        },
        {
          "_id": "ride_107",
          "customer": {"name": "Karan Johar", "phoneNumber": "+91-8765432108"},
          "pickupLocation": {
            "address": "Vasant Vihar, New Delhi",
            "pincode": "110057",
            "coordinates": [77.2089, 28.5245],
          },
          "dropoffLocation": {
            "address": "Dilli Haat, INA, New Delhi",
            "pincode": "110023",
            "coordinates": [77.2090, 28.6139],
          },
          "pickupTime": "2024-01-14T12:00:00.000Z",
          "startTime": "2024-01-14T12:05:00.000Z",
          "endTime": "2024-01-14T12:30:00.000Z",
          "status": "Refunded",
        }
      ];
      final convertedData = (bookings as List<dynamic>)
          .map((e) => Ride.fromJson(e as Map<String, dynamic>))
          .toList();

      return convertedData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> startRide(
    String rideId,
    String otp,
  ) async {
    try {
      //   final accessToken =
      //       CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      //   final requestUri = Uri.https(
      //     AppApis.baseUrl,
      //     '${AppApis.drStartTrip}/$rideId',
      //   );

      //   await _dio.postUri(
      //     requestUri,
      //     data: {'enteredOTP': otp},
      //     options: Options(
      //       headers: {
      //         'Authorization': 'Bearer $accessToken',
      //         'Accept': 'application/json',
      //       },
      //       responseType: ResponseType.json,
      //     ),
      //   );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> endRide(String rideId) async {
    try {
      // final accessToken =
      //     CacheService.get(AppConstants.sharedPreferenceAccessTokenKey);

      // final requestUri = Uri.https(
      //   AppApis.baseUrl,
      //   '${AppApis.drEndTrip}/$rideId',
      // );

      // await _dio.postUri(
      //   requestUri,
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
