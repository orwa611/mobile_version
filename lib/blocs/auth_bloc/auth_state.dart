part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateSucces extends AuthState {
  final String token;
  AuthStateSucces({required this.token});
}

class AuthStateError extends AuthState {
  final String errorMessage;
  AuthStateError({required this.errorMessage});
}
