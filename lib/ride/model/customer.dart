class Customer {
  Customer({
    this.name,
    this.phoneNumber,
  });

  String? name;
  String? phoneNumber;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json['name'] != null ? json['name'] as String : null,
        phoneNumber:
            json['phoneNumber'] != null ? json['phoneNumber'] as String : null,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
      };
}
