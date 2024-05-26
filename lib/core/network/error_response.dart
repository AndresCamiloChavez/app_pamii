class ResponsePamii<T> {
  String? messageError;
  bool isFailure;
  T? response;

  ResponsePamii({
    this.isFailure = false,
    this.response,
    this.messageError,
  });

 factory ResponsePamii.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ResponsePamii<T>(
      messageError: json['messageError'] as String?,
      isFailure: json['isFailure'] as bool? ?? false,
      response: json['response'] != null ? fromJsonT(json['response']) : null,
    );
  }
}
class ErrorResponse {
    String message;
    String error;
    int statusCode;

    ErrorResponse({
        required this.message,
        required this.error,
        required this.statusCode,
    });

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: json["message"],
        error: json["error"],
        statusCode: json["statusCode"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "statusCode": statusCode,
    };
}