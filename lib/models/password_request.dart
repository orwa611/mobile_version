class PasswordRequest {
  final String _currentPassword;
  final String _newPassword;

  PasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) : _currentPassword = currentPassword,
       _newPassword = newPassword;

  Map<String, dynamic> toJson() {
    return {'password': _currentPassword, 'newPassword': _newPassword};
  }
}
