part of 'article_bloc.dart';

abstract class ArticleEvent {}

class GetArticlesEvent extends ArticleEvent {
  final int page;

  GetArticlesEvent({this.page = 1});
}
