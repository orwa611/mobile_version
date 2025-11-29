part of 'create_article_bloc.dart';

abstract class CreateArticleEvent {}

class ShareArticleEvent implements CreateArticleEvent {
  final ArticleRequest request;

  ShareArticleEvent({required this.request});
}
