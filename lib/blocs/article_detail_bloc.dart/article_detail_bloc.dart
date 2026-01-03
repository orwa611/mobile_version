import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_detail_model.dart';
import 'package:mobile_version/models/comment_model.dart';
import 'package:mobile_version/services/article_service.dart';

part 'article_detail_event.dart';
part 'article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleService _service;

  ArticleDetailBloc({required ArticleService service})
    : _service = service,
      super(ArticleDetailStateInitial()) {
    on<GetArticleDetailEvent>((event, emit) async {
      emit(ArticleDetailStateLoading());
      try {
        final result = await _service.getArticle(event.id);
        emit(ArticleDetailStateSuccess(article: result.toArticleDetail()));
      } on AppException catch (e) {
        emit(ArticleDetailStateError(errorMessage: e.message));
      }
    });
    on<AddCommentToArticleEvent>((event, emit) {
      if (state is ArticleDetailStateSuccess) {
        final article = (state as ArticleDetailStateSuccess).article;
        emit(ArticleDetailStateLoading());
        article.comments.insert(0, event.comment);
        emit(ArticleDetailStateSuccess(article: article));
      }
    });
  }
}
