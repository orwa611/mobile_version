part of 'my_account_bloc.dart';

abstract class MyAccountEvent {}

class GetMyAccountEvent extends MyAccountEvent {}

class DeleteMyArticleEvent extends MyAccountEvent {
  final String id;

  DeleteMyArticleEvent({required this.id});
}

class UnauthenticatedMyAccountEvent extends MyAccountEvent {}
