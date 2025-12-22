import 'package:flutter/material.dart';
import 'package:mobile_version/core/constants/logo_constants.dart';
import 'package:mobile_version/pages/register/register_form_model.dart';
import 'package:mobile_version/pages/register/register_notifier.dart';
import 'package:mobile_version/widgets/input_field.dart';
import 'package:mobile_version/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  static const String route = '/register';
  final RegisterNotifier registerNotifier;
  final Function(RegisterFormModel) onRegister;
  final bool isLoading;

  const RegisterPage({
    super.key,
    required this.registerNotifier,
    required this.onRegister,
    required this.isLoading,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    widget.registerNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(LogoConstants.logo, height: 40),
            SizedBox(height: 48.0),
            ListenableBuilder(
              listenable: widget.registerNotifier,
              builder: (context, _) {
                return Form(
                  key: widget.registerNotifier.globalKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create your Account',
                          style: TextStyle(fontSize: 26),
                        ),
                        InputField(
                          hintText: 'First name',
                          validator: widget.registerNotifier.validateFirstName,
                          onSaved: widget.registerNotifier.saveFirstName,
                        ),
                        InputField(
                          hintText: 'Last name',
                          validator: widget.registerNotifier.validateLastName,
                          onSaved: widget.registerNotifier.saveLastName,
                        ),
                        InputField(
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: widget.registerNotifier.validateEmail,
                          onSaved: widget.registerNotifier.saveEmail,
                        ),
                        InputField(
                          hintText: 'Password',
                          obscureText: true,
                          validator: widget.registerNotifier.validatePassword,
                          onSaved: widget.registerNotifier.savePassword,
                        ),
                        PrimaryButton(
                          onPressed:
                              widget.isLoading
                                  ? null
                                  : () {
                                    widget.registerNotifier.registerForm(
                                      widget.onRegister,
                                    );
                                  },
                          title: 'Sign up',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
