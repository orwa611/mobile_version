class RegisterResponse {
  final String name;
  final String lastname;
  final String email;

  RegisterResponse({
    required this.name,
    required this.lastname,
    required this.email,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final lastname = json['lastname'] as String;
    final email = json['email'] as String;
    return RegisterResponse(name: name, lastname: lastname, email: email);
  }
}
