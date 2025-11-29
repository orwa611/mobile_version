part of 'edit_article_bloc.dart';

abstract class EditArticleEvent {}

class GetArticleToEditEvent implements EditArticleEvent {
  final Article article;

  GetArticleToEditEvent({required this.article});
}
