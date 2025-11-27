class RegisterRequest {
  final String _firstName;
  final String _lastName;
  final String _email;
  final String _password;

  RegisterRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) : _firstName = firstName,
       _lastName = lastName,
       _email = email,
       _password = password;

  Map<String, dynamic> toJson() {
    return {
      'name': _firstName,
      'lastname': _lastName,
      'email': _email,
      'password': _password,
    };
  }
}
