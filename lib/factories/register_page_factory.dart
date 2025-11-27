import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/register_bloc/register_bloc.dart';
import 'package:mobile_version/blocs/register_bloc/register_event.dart';
import 'package:mobile_version/blocs/register_bloc/register_state.dart';
import 'package:mobile_version/models/register_request.dart';
import 'package:mobile_version/pages/register/register_notifier.dart';
import 'package:mobile_version/pages/register/register_page.dart';

final class RegisterPageFactory {
  static Widget buildRegisterPage(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegistrationStateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is RegistrationStateSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account created successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return RegisterPage(
          isLoading: state is RegistrationStateLoading,
          registerNotifier: DefaultRegisterNotifier(
            globalKey: GlobalKey<FormState>(),
          ),
          onRegister: (form) {
            context.read<RegisterBloc>().add(
              RegisterEvent(
                request: RegisterRequest(
                  firstName: form.firstName,
                  lastName: form.lastName,
                  email: form.email,
                  password: form.password,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
