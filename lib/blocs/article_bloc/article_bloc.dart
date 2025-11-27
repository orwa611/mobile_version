import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/services/article_service.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleService _service;

  ArticleBloc({required ArticleService service})
    : _service = service,
      super(ArticleStateInitial()) {
    on<GetArticlesEvent>((event, emit) async {
      emit(ArticleStateLoading());
      try {
        final result = await _service.getArticles();
        emit(
          ArticleStateSuccess(
            articles: result.articles.map((e) => e.toArticle()).toList(),
          ),
        );
      } on AppException catch (e) {
        emit(ArticleStateError(errorMessage: e.message));
      }
    });
  }
}
