part of 'user_bloc.dart';

abstract class UserEvent {}

class UserLoggedInEvent extends UserEvent {}

class UserLoggedOutEvent extends UserEvent {}
