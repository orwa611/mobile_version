import 'package:flutter/widgets.dart';
import 'package:mobile_version/core/extensions/string_extension.dart';
import 'package:mobile_version/pages/edit_profile/update_profile_model.dart';

abstract class EditProfileNotifier extends ChangeNotifier {
  final GlobalKey<FormState> globalKey;
  UpdateProfileModel model;
  EditProfileNotifier({required this.globalKey, required this.model});

  String? validateFirstName(String? value);
  void saveFirstName(String? value);
  String? validateLastName(String? value);
  void saveLastName(String? value);
  String? validateEmail(String? value);
  void saveEmail(String? value);
  String? validateBio(String? value);
  void saveBio(String? value);

  void updateProfile(Function(UpdateProfileModel) callBack);
}

class EditProfileNotifierImpl extends EditProfileNotifier {
  EditProfileNotifierImpl({required super.globalKey, required super.model});

  @override
  void saveFirstName(String? value) {
    model.firstName = value ?? '';
  }

  @override
  String? validateFirstName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return 'Your first name is required';
  }

  @override
  void saveEmail(String? value) {
    model.email = value ?? '';
  }

  @override
  void saveLastName(String? value) {
    model.lastName = value ?? '';
  }

  @override
  String? validateEmail(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.isEmail()) {
        return null;
      } else {
        return 'Please provide a valid email';
      }
    } else {
      return 'Email is required !';
    }
  }

  @override
  String? validateLastName(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return 'Your last name is required';
  }

  @override
  void saveBio(String? value) {
    if (value != null && value.isEmpty) {
      model.bio = value;
    }
  }

  @override
  String? validateBio(String? value) {
    return null;
  }

  @override
  void updateProfile(Function(UpdateProfileModel) callBack) {
    if (globalKey.currentState != null && globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      callBack(model);
    }
  }
}
