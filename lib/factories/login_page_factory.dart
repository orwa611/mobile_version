import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/auth_bloc/auth_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/blocs/user_bloc/user_bloc.dart';
import 'package:mobile_version/pages/login/login_page.dart';
import 'package:mobile_version/pages/register/register_page.dart';

final class LoginPageFactory {
  static Widget buildLoginPage(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
        if (state is AuthStateSucces) {
          context.read<UserBloc>().add(UserLoggedInEvent());
          context.read<MyAccountBloc>().add(GetMyAccountEvent());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return LoginPage(
          onLogin: (email, password) async {
            context.read<AuthBloc>().add(
              LoginEvent(email: email, password: password),
            );
          },
          isLoading: state is AuthStateLoading,
          onGoToRegister:
              () => Navigator.of(context).pushNamed(RegisterPage.route),
        );
      },
    );
  }
}
