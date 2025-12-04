part of 'form_article_bloc.dart';

abstract class FormArticleEvent {}

class ShareArticleEvent implements FormArticleEvent {
  final ArticleRequest request;

  ShareArticleEvent({required this.request});
}

class EditArticleEvent implements FormArticleEvent {
  final ArticleRequest request;
  final String id;

  EditArticleEvent(this.id, {required this.request});
}
