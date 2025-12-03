part of 'edit_article_bloc.dart';

abstract class EditArticleState {}

class EditArticleInitialState implements EditArticleState {}

class EditArticleLoadingState implements EditArticleState {}

class EditArticleSuccessState implements EditArticleState {
  final Article article;

  EditArticleSuccessState({required this.article});
}

class EditArticleErrorState implements EditArticleState {}
