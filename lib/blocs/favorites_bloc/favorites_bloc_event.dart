part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesBlocEvent {}

final class FavoriteArticleEvent extends FavoritesBlocEvent {
  final Article article;

  FavoriteArticleEvent({required this.article});
}

final class UnFavoriteArticleEvent extends FavoritesBlocEvent {
  final Article article;

  UnFavoriteArticleEvent({required this.article});
}

final class GetFavoriteArticleEvent extends FavoritesBlocEvent {}
