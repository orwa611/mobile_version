import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/author_bloc/author_event.dart';
import 'package:mobile_version/blocs/author_bloc/author_state.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/services/author_service.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorService _service;
  AuthorBloc({required AuthorService service})
    : _service = service,
      super(AuthorInitialState()) {
    on<GetAuthorEvent>((event, emit) async {
      emit(AuthorLoadingState());
      try {
        final author = await _service.getAuthorProfile(event.id);
        final articles = await _service.getAuthorArticles(event.id);
        emit(
          AuthorSuccessState(
            articles: articles.map((e) => e.toArticle()).toList(),
            author: author.toAuthorModel(),
          ),
        );
      } on AppNetworkException catch (e) {
        emit(AuthorErrorState(errorMessage: e.message));
      }
    });
  }
}
