import 'package:easy_rider/ride/model/cab.dart';
import 'package:easy_rider/ride/model/driver.dart';

class DataUI {
  DataUI({
    this.minVersion,
    this.maxVersion,
    this.driver,
    this.cab,
  });

  String? minVersion;
  String? maxVersion;

  Driver? driver;
  Cab? cab;

  factory DataUI.fromJson(Map<String, dynamic> json) => DataUI(
        minVersion:
            json['min_version'] != null ? json['min_version'] as String : null,
        maxVersion:
            json['max_version'] != null ? json['max_version'] as String : null,
        driver: json['driver'] != null
            ? Driver.fromJson(json['driver'] as Map<String, dynamic>)
            : null,
        cab: json['cab'] != null
            ? Cab.fromJson(json['cab'] as Map<String, dynamic>)
            : null,
      );
}
