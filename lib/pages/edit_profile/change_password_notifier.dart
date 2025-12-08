import 'package:flutter/widgets.dart';
import 'package:mobile_version/models/password_model.dart';

abstract class ChangePasswordNotifier extends ChangeNotifier {
  final GlobalKey<FormState> globalKey;
  final PasswordModel model;

  ChangePasswordNotifier({required this.globalKey, required this.model});

  String? validateCurrentPassword(String? value);
  String? validatenewPassword(String? value);
  String? validateconfirmNewPassword(String? value);

  void saveCurrentPassword(String? value);
  void savenewPassword(String? value);
  void saveconfirmNewPassword(String? value);

  void changePassword(Function(PasswordModel) callback);
}

class ChangePasswordNotifierImpl extends ChangePasswordNotifier {
  ChangePasswordNotifierImpl({required super.globalKey, required super.model});

  @override
  void changePassword(Function(PasswordModel) callback) {
    if (globalKey.currentState != null && globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      callback(model);
    }
  }

  @override
  void saveCurrentPassword(String? value) {
    model.currentPassword = value ?? '';
  }

  @override
  void saveconfirmNewPassword(String? value) {
    model.currentPassword = value ?? '';
  }

  @override
  void savenewPassword(String? value) {
    model.newPassword = value ?? '';
  }

  @override
  String? validateCurrentPassword(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return 'your password is required';
  }

  @override
  String? validateconfirmNewPassword(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value == model.newPassword) {
        return null;
      }
      return 'your new password doesnt match !';
    }
    return 'your confirmation password is required';
  }

  @override
  String? validatenewPassword(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return 'your new password is required';
  }
}
