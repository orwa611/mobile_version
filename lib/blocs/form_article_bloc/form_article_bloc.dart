import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/services/article_service_manager.dart';
part 'form_article_event.dart';
part 'form_article_state.dart';

class FormArticleBloc extends Bloc<FormArticleEvent, FormArticleState> {
  final ArticleServiceManager _service;

  FormArticleBloc({required ArticleServiceManager service})
    : _service = service,
      super(FormArticleInitialState()) {
    on<ShareArticleEvent>((event, emit) async {
      emit(FormArticleLoadingState());
      try {
        await _service.createArticle(event.request);
        emit(FormArticleSuccessState());
      } on AppException catch (e) {
        emit(FormArticleErrorState(errorMessage: e.message));
      }
    });
    on<EditArticleEvent>((event, emit) async {
      emit(FormArticleLoadingState());
      try {
        await _service.editArticle(event.request, event.id);
        emit(FormArticleSuccessState());
      } on AppException catch (e) {
        emit(FormArticleErrorState(errorMessage: e.message));
      }
    });
  }
}
