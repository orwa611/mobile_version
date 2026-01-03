import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_bloc.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_event.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_state.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/blocs/user_bloc/user_bloc.dart';
import 'package:mobile_version/core/extensions/context_extension.dart';
import 'package:mobile_version/models/password_model.dart';
import 'package:mobile_version/pages/edit_profile/change_password_notifier.dart';
import 'package:mobile_version/pages/edit_profile/edit_profile_notifier.dart';
import 'package:mobile_version/pages/edit_profile/edit_profile_page.dart';
import 'package:mobile_version/pages/edit_profile/update_profile_model.dart';

class EditProfileFactory {
  static Widget buildEditProfilePage(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, passwordState) {
        if (passwordState is ChangePasswordSuccessState) {
          context.read<UserBloc>().add(UserLoggedOutEvent());
          context.read<MyAccountBloc>().add(UnauthenticatedMyAccountEvent());
          Navigator.of(context).pop();
          context.snackBar(
            'Your password has bees changed successfully ! please login again',
          );
        }
        if (passwordState is ChangePasswordErrorState) {
          context.snackBar(
            passwordState.errorMessage,
            status: SnackBarStatus.error,
          );
        }
      },
      child: BlocBuilder<MyAccountBloc, MyAccountState>(
        builder: (context, state) {
          if (state is MyAccountStateSuccess) {
            return EditProfilePage(
              notifier: EditProfileNotifierImpl(
                globalKey: GlobalKey(),
                model: UpdateProfileModel(
                  firstName: state.author.firstName,
                  lastName: state.author.lastName,
                  email: state.author.email,
                  bio: state.author.about,
                ),
              ),
              isLoading: false,
              onUpdate: (model) {
                context.read<MyAccountBloc>().add(
                  UpdateMyAccountEvent(author: model),
                );
                Navigator.of(context).pop();
              },
              passwordNotifier: ChangePasswordNotifierImpl(
                globalKey: GlobalKey(),
                model: PasswordModel.initialize(),
              ),
              onChange: (passwordModel) {
                context.read<ChangePasswordBloc>().add(
                  UpdatePasswordEvent(request: passwordModel.toRequest()),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
