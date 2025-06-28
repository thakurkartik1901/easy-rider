class ReferalResponse {
  ReferalResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ReferalResponse.fromJson(Map<String, dynamic> json) =>
      ReferalResponse(
        status: json['status'] != null ? json['status'] as bool : false,
        message: json['message'] != null ? json['message'] as String : null,
      );
}
