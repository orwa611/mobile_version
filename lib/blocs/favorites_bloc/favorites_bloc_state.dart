part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesBlocState {}

final class FavoritesBlocInitial extends FavoritesBlocState {}

final class FavoritesBlocLoading extends FavoritesBlocState {}

final class FavoritesBlocSuccess extends FavoritesBlocState {}

final class FavoritesBlocError extends FavoritesBlocState {}
