part of 'article_detail_bloc.dart';

abstract class ArticleDetailState {}

class ArticleDetailStateInitial extends ArticleDetailState {}

class ArticleDetailStateLoading extends ArticleDetailState {}

class ArticleDetailStateSuccess extends ArticleDetailState {
  final ArticleDetail article;

  ArticleDetailStateSuccess({required this.article});
}

class ArticleDetailStateError extends ArticleDetailState {
  final String errorMessage;

  ArticleDetailStateError({required this.errorMessage});
}
