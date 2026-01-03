import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/author_model.dart';

abstract class AuthorState {}

class AuthorInitialState extends AuthorState {}

class AuthorSuccessState extends AuthorState {
  final List<Article> articles;
  final Author author;

  AuthorSuccessState({required this.articles, required this.author});
}

class AuthorLoadingState extends AuthorState {}

class AuthorErrorState extends AuthorState {
  final String errorMessage;

  AuthorErrorState({required this.errorMessage});
}
