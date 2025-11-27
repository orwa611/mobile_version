part of 'article_detail_bloc.dart';

abstract class ArticleDetailEvent {}

class GetArticleDetailEvent extends ArticleDetailEvent {
  final String id;

  GetArticleDetailEvent({required this.id});
}

class AddCommentToArticleEvent extends ArticleDetailEvent {
  final CommentModel comment;

  AddCommentToArticleEvent({required this.comment});
}
