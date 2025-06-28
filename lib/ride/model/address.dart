class Address {
  Address({
    this.address,
    this.pincode,
    this.latitude,
    this.longitude,
  });

  String? address;
  String? pincode;
  double? latitude;
  double? longitude;

  factory Address.fromJson(Map<String, dynamic> json) {
    var coordinates = [];
    if (json['coordinates'] != null) {
      coordinates = json['coordinates'] as List<dynamic>;
    }
    return Address(
      address: json['address'] != null ? json['address'] as String : null,
      pincode: json['pincode'] != null ? json['pincode'] as String : null,
      latitude: coordinates.isNotEmpty ? coordinates[1] as double : null,
      longitude: coordinates.isNotEmpty ? coordinates[0] as double : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'pincode': pincode,
        'latitude': latitude,
        'longitude': longitude,
      };
}
