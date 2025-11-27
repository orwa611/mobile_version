part of 'user_bloc.dart';

abstract class UserState {}

class UserStateInitial extends UserState {}

class UserStateLoggedIn extends UserState {}

class UserStateLoggedOut extends UserState {}
