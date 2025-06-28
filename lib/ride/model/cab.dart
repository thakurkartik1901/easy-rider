class Cab {
  Cab({
    this.registrationNumber,
    this.model,
    this.make,
    this.year,
    this.available,
  });

  String? registrationNumber;
  String? model;
  String? make;
  int? year;
  bool? available;

  factory Cab.fromJson(Map<String, dynamic> json) => Cab(
        registrationNumber: json['registrationNumber'] != null
            ? json['registrationNumber'] as String
            : null,
        model: json['model'] != null ? json['model'] as String : null,
        make: json['make'] != null ? json['make'] as String : null,
        year: json['year'] != null ? json['year'] as int : null,
        available:
            json['available'] != null ? json['available'] as bool : false,
      );
}
