part of 'my_account_bloc.dart';

abstract class MyAccountState {}

class MyAccountStateLoading implements MyAccountState {}

class MyAccountStateSuccess implements MyAccountState {
  final List<Article> articles;
  final Author author;

  MyAccountStateSuccess({required this.articles, required this.author});
}

class MyAccountStateInitial implements MyAccountState {}

class MyAccountStateError implements MyAccountState {
  final String errorMessage;

  MyAccountStateError({required this.errorMessage});
}

class MyAccountStateUnauthenticated implements MyAccountState {
  final String errorMessage;

  MyAccountStateUnauthenticated({required this.errorMessage});
}

class MyArticleStateDeleted extends MyAccountState {}
