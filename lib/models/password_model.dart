import 'package:mobile_version/models/password_request.dart';

final class PasswordModel {
  String currentPassword;
  String newPassword;
  String confirmNewPassword;

  PasswordModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });
  factory PasswordModel.initialize() {
    return PasswordModel(
      currentPassword: '',
      newPassword: '',
      confirmNewPassword: '',
    );
  }
  PasswordRequest toRequest() {
    return PasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
