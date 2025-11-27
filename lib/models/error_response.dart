class ErrorResponse {
  final String message;

  ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    String resMessage = '';
    if (json['message'] != null) {
      resMessage = json['message'] as String;
    } else if (json['msg'] != null) {
      resMessage = json['msg'] as String;
    }
    return ErrorResponse(message: resMessage);
  }
}
