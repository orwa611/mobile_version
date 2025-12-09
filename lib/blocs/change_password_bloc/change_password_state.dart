abstract class ChangePasswordState {}

class ChangePasswordLoadingState implements ChangePasswordState {}

class ChangePasswordInitialState implements ChangePasswordState {}

class ChangePasswordSuccessState implements ChangePasswordState {}

class ChangePasswordErrorState implements ChangePasswordState {
  final String errorMessage;

  ChangePasswordErrorState({required this.errorMessage});
}
