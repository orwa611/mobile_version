part of 'create_article_bloc.dart';

abstract class CreateArticleState {}

class CreateArticleInitialState implements CreateArticleState {}

class CreateArticleLoadingState implements CreateArticleState {}

class CreateArticleSuccessState implements CreateArticleState {}

class CreateArticleErrorState implements CreateArticleState {
  final String errorMessage;

  CreateArticleErrorState({required this.errorMessage});
}
