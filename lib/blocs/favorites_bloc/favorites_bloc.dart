import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/services/favorite_article_service.dart';

part 'favorites_bloc_event.dart';
part 'favorites_bloc_state.dart';

class FavoritesBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> {
  final FavoriteArticleService _service;
  FavoritesBloc({required FavoriteArticleService service})
    : _service = service,
      super(FavoritesStateInitial()) {
    on<FavoriteArticleEvent>((event, emit) async {
      final list = (state as ListFavoritesStateSuccess).favArticles;
      final result = await _service.insertArticle(article: event.article);
      if (result) {
        list.add(event.article);
        emit(ListFavoritesStateSuccess(favArticles: list));
      }
    });
    on<UnFavoriteArticleEvent>((event, emit) async {
      final list = (state as ListFavoritesStateSuccess).favArticles;
      final result = await _service.removeArticle(article: event.article);
      if (result) {
        list.remove(event.article);
        emit(ListFavoritesStateSuccess(favArticles: list));
      }
    });
    on<GetFavoriteArticleEvent>((event, emit) async {
      emit(FavoritesStateLoading());
      final result = await _service.getArticles();
      emit(ListFavoritesStateSuccess(favArticles: result));
    });
  }
}
