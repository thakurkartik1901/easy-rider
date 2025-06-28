import 'package:easy_rider/ride/model/customer.dart';

class Driver {
  Driver({
    this.name,
    this.phone,
    this.taxiService,
    this.licenseNumber,
    this.profilePic,
  });

  Customer? customer;
  String? name;
  String? phone;
  String? taxiService;
  String? licenseNumber;
  String? profilePic;

  factory Driver.fromJson(Map<String, dynamic> json) {
    Customer? customer;
    if (json['user'] != null) {
      customer = Customer.fromJson(json['user'] as Map<String, dynamic>);
    }
    return Driver(
      name: customer?.name,
      phone: customer?.phoneNumber,
      taxiService:
          json['taxiService'] != null ? json['taxiService'] as String : null,
      licenseNumber: json['licenseNumber'] != null
          ? json['licenseNumber'] as String
          : null,
      profilePic:
          json['profile_pic'] != null ? json['profile_pic'] as String : null,
    );
  }
}
