import 'package:flutter/material.dart';
import 'package:mobile_version/core/extensions/string_extension.dart';
import 'package:mobile_version/pages/register/register_form_model.dart';

abstract class RegisterNotifier extends ChangeNotifier {
  final GlobalKey<FormState> globalKey;

  RegisterNotifier({required this.globalKey});

  String? validateFirstName(String? value);
  void saveFirstName(String? value);

  String? validateLastName(String? value);
  void saveLastName(String? value);

  String? validateEmail(String? value);
  void saveEmail(String? value);

  String? validatePassword(String? value);
  void savePassword(String? value);

  void registerForm(Function(RegisterFormModel) callBack);
}

class DefaultRegisterNotifier extends RegisterNotifier {
  RegisterFormModel registerFormModel = RegisterFormModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
  );
  DefaultRegisterNotifier({required super.globalKey});

  @override
  void registerForm(Function(RegisterFormModel) callBack) {
    if (globalKey.currentState != null) {
      if (globalKey.currentState!.validate()) {
        globalKey.currentState!.save();
        callBack(registerFormModel);
      }
    }
  }

  @override
  void saveEmail(String? value) {
    if (value != null) registerFormModel.email = value;
  }

  @override
  void savePassword(String? value) {
    if (value != null) registerFormModel.password = value;
  }

  @override
  String? validateEmail(String? value) {
    // if (value != null && value.isNotEmpty) {
    // return value.isEmail() ? null : 'Email is not valid !';
    // } else {
    // return 'Email is required';
    // }

    return value != null && value.isNotEmpty
        ? value.isEmail()
            ? null
            : 'Email is not valid !'
        : 'Email is required';
  }

  @override
  String? validatePassword(String? value) {
    return value != null && value.isNotEmpty
        ? value.isValidPassword()
            ? null
            : 'Password should be at least 6 characters'
        : 'Password is required';
  }

  @override
  void saveFirstName(String? value) {
    if (value != null) registerFormModel.firstName = value;
  }

  @override
  void saveLastName(String? value) {
    if (value != null) registerFormModel.lastName = value;
  }

  @override
  String? validateFirstName(String? value) {
    return _isRequired(value);
  }

  @override
  String? validateLastName(String? value) {
    return _isRequired(value);
  }

  String? _isRequired(String? value) {
    return value != null && value.isNotEmpty ? null : 'This field is required';
  }
}
