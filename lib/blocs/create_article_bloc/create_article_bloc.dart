import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/services/article_service_manager.dart';
part 'create_article_event.dart';
part 'create_article_state.dart';

class CreateArticleBloc extends Bloc<CreateArticleEvent, CreateArticleState> {
  final ArticleServiceManager _service;

  CreateArticleBloc({required ArticleServiceManager service})
    : _service = service,
      super(CreateArticleInitialState()) {
    on<ShareArticleEvent>((event, emit) async {
      emit(CreateArticleLoadingState());
      try {
        await _service.createArticle(event.request);
        emit(CreateArticleSuccessState());
      } on AppException catch (e) {
        emit(CreateArticleErrorState(errorMessage: e.message));
      }
    });
  }
}
