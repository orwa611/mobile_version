import 'package:flutter/material.dart';
import 'package:mobile_version/core/constants/logo_constants.dart';
import 'package:mobile_version/core/extensions/string_extension.dart';
import 'package:mobile_version/widgets/input_field.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';
  final bool isLoading;
  final VoidCallback? onGoToRegister;

  final void Function(String email, String password) onLogin;

  LoginPage({
    super.key,
    required this.onLogin,
    required this.isLoading,
    required this.onGoToRegister,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final globalKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(LogoConstants.logo, height: 40),
            SizedBox(height: 48.0),
            Form(
              key: globalKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your Account',
                      style: TextStyle(fontSize: 26),
                    ),
                    InputField(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        } else if (!value.isEmail()) {
                          return 'Email is not valid';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) email = value;
                      },
                    ),
                    InputField(
                      hintText: 'Password',
                      obscureText: true,
                      onSaved: (value) {
                        if (value != null) password = value;
                      },
                    ),
                    PrimaryButton(
                      onPressed:
                          widget.isLoading
                              ? null
                              : () {
                                if (globalKey.currentState != null) {
                                  final isValid =
                                      globalKey.currentState!.validate();
                                  if (isValid) {
                                    globalKey.currentState!.save();
                                    widget.onLogin(email, password);
                                  }
                                }
                              },
                      title: 'Sign in',
                    ),
                    Center(
                      child: TextButton(
                        onPressed: widget.onGoToRegister,
                        child: Text('Create account ?'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
