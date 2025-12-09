import 'package:flutter/material.dart';
import 'package:mobile_version/models/password_model.dart';
import 'package:mobile_version/pages/edit_profile/change_password_notifier.dart';
import 'package:mobile_version/pages/edit_profile/edit_profile_notifier.dart';
import 'package:mobile_version/pages/edit_profile/update_profile_model.dart';
import 'package:mobile_version/widgets/input_field.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class EditProfilePage extends StatefulWidget {
  static const String route = '/edit_profile';
  final EditProfileNotifier notifier;
  final ChangePasswordNotifier passwordNotifier;
  final bool isLoading;
  final Function(UpdateProfileModel) onUpdate;
  final Function(PasswordModel) onChange;

  const EditProfilePage({
    super.key,
    required this.notifier,
    required this.isLoading,
    required this.onUpdate,
    required this.passwordNotifier,
    required this.onChange,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('logo.png', height: 40),
            ExpansionTile(
              title: Text('Edit your Profile', style: TextStyle(fontSize: 26)),
              children: [
                ListenableBuilder(
                  listenable: widget.notifier,
                  builder: (context, _) {
                    return Form(
                      key: widget.notifier.globalKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputField(
                              initialValue: widget.notifier.model.firstName,
                              hintText: 'First name',
                              validator: widget.notifier.validateFirstName,
                              onSaved: widget.notifier.saveFirstName,
                            ),
                            InputField(
                              initialValue: widget.notifier.model.lastName,
                              hintText: 'Last name',
                              validator: widget.notifier.validateLastName,
                              onSaved: widget.notifier.saveLastName,
                            ),
                            InputField(
                              initialValue: widget.notifier.model.email,
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              validator: widget.notifier.validateEmail,
                              onSaved: widget.notifier.saveEmail,
                            ),
                            InputField(
                              initialValue: widget.notifier.model.bio,
                              hintText: 'Bio',
                              validator: widget.notifier.validateBio,
                              onSaved: widget.notifier.saveBio,
                            ),

                            PrimaryButton(
                              onPressed:
                                  widget.isLoading
                                      ? null
                                      : () {
                                        widget.notifier.updateProfile(
                                          widget.onUpdate,
                                        );
                                      },
                              title: 'Edit',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Change Password', style: TextStyle(fontSize: 26)),
              children: [
                ListenableBuilder(
                  listenable: widget.passwordNotifier,
                  builder: (context, _) {
                    return Form(
                      key: widget.passwordNotifier.globalKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Column(
                          spacing: 12,
                          children: [
                            InputField(
                              hintText: 'Current password',
                              obscureText: true,
                              onSaved:
                                  widget.passwordNotifier.saveCurrentPassword,
                              validator:
                                  widget
                                      .passwordNotifier
                                      .validateCurrentPassword,
                            ),
                            InputField(
                              hintText: 'New password',
                              obscureText: true,
                              onSaved: widget.passwordNotifier.savenewPassword,
                              validator:
                                  widget.passwordNotifier.validatenewPassword,
                            ),
                            InputField(
                              hintText: 'Confirm New password',
                              obscureText: true,
                              onSaved:
                                  widget
                                      .passwordNotifier
                                      .saveconfirmNewPassword,
                              validator:
                                  widget
                                      .passwordNotifier
                                      .validateconfirmNewPassword,
                            ),
                            PrimaryButton(
                              onPressed:
                                  widget.isLoading
                                      ? null
                                      : () {
                                        widget.passwordNotifier.changePassword(
                                          widget.onChange,
                                        );
                                      },
                              title: 'change password',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
