part of 'article_bloc.dart';

abstract class ArticleState {}

class ArticleStateInitial extends ArticleState {}

class ArticleStateLoading extends ArticleState {}

class ArticleStateSuccess extends ArticleState {
  final List<Article> articles;

  ArticleStateSuccess({required this.articles});
}

class ArticleStateError extends ArticleState {
  final String errorMessage;

  ArticleStateError({required this.errorMessage});
}
