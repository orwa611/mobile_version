part of 'form_article_bloc.dart';

abstract class FormArticleState {}

class FormArticleInitialState implements FormArticleState {}

class FormArticleLoadingState implements FormArticleState {}

class FormArticleSuccessState implements FormArticleState {}

class FormArticleErrorState implements FormArticleState {
  final String errorMessage;

  FormArticleErrorState({required this.errorMessage});
}
