import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/services/article_service.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleService _service;
  final ArticleRefreshableCubit _refreshableCubit;

  ArticleBloc({
    required ArticleService service,
    required ArticleRefreshableCubit refreshableCubit,
  }) : _service = service,
       _refreshableCubit = refreshableCubit,
       super(ArticleStateInitial()) {
    on<GetArticlesEvent>((event, emit) async {
      List<Article> list =
          (state is ArticleStateSuccess)
              ? (state as ArticleStateSuccess).articles
              : [];
      if (event.page == 1) {
        list = [];
        emit(ArticleStateLoading());
      } else {
        _refreshableCubit.showLoader();
      }
      try {
        final result = await _service.getArticles(page: event.page);
        list.addAll(result.articles.map((e) => e.toArticle()).toList());
        emit(ArticleStateSuccess(articles: list));
        _refreshableCubit.hideLoader();
      } on AppException catch (e) {
        emit(ArticleStateError(errorMessage: e.message));
        _refreshableCubit.hideLoader();
      }
    });
  }
}

final class ArticleRefreshableCubit extends Cubit<bool> {
  ArticleRefreshableCubit() : super(false);
  void showLoader() {
    emit(true);
  }

  void hideLoader() {
    emit(false);
  }
}
