import 'package:mobile_version/models/password_request.dart';

abstract class ChangePasswordEvent {}

class UpdatePasswordEvent implements ChangePasswordEvent {
  final PasswordRequest request;

  UpdatePasswordEvent({required this.request});
}
