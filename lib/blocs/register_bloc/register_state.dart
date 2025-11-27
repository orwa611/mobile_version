abstract class RegisterState {}

class RegistrationStateInitial extends RegisterState {}

class RegistrationStateLoading extends RegisterState {}

class RegistrationStateSuccess extends RegisterState {}

class RegistrationStateError extends RegisterState {
  final String errorMessage;

  RegistrationStateError({required this.errorMessage});
}
