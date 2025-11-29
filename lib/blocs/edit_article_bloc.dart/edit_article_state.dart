part of 'edit_article_bloc.dart';

abstract class EditArticleState {}

class EditArticleInitialState implements EditArticleState {}

class EditArticleLoadingState implements EditArticleState {}

class EditArticleSuccessState implements EditArticleState {}

class EditArticleErrorState implements EditArticleState {}
