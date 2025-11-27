class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final resToken = json['token'] as String;
    return LoginResponse(token: resToken);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
