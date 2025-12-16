part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesBlocState {}

final class FavoritesStateInitial extends FavoritesBlocState {}

final class FavoritesStateLoading extends FavoritesBlocState {}

final class FavoritesStateSuccess extends FavoritesBlocState {}

final class ListFavoritesStateSuccess extends FavoritesBlocState {
  final List<Article> favArticles;

  ListFavoritesStateSuccess({required this.favArticles});
}

final class FavoritesStateError extends FavoritesBlocState {}
