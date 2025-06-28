class FirebaseUser {
  FirebaseUser({this.firstName, this.emailAddress});

  String? emailAddress;
  String? firstName;

  factory FirebaseUser.fromJson(Map<String, dynamic> json) => FirebaseUser(
        emailAddress: json['emailAddress'] != null
            ? json['emailAddress'] as String
            : null,
        firstName:
            json['firstName'] != null ? json['firstName'] as String : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'firstName': firstName,
    };
  }
}
