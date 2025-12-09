import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/pages/edit_profile/update_profile_model.dart';
import 'package:mobile_version/services/account_service.dart';
part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  final AccountService _service;

  MyAccountBloc({required AccountService service})
    : _service = service,
      super(MyAccountStateInitial()) {
    on<GetMyAccountEvent>((event, emit) async {
      emit(MyAccountStateLoading());
      try {
        final result = await _service.getMyAccount();
        emit(
          MyAccountStateSuccess(
            articles: result.articles.map((e) => e.toArticle()).toList(),
            author: result.toAuthor(),
          ),
        );
      } on AppException catch (e) {
        if (e is AppUnauthenticatedException) {
          emit(MyAccountStateUnauthenticated(errorMessage: e.message));
        } else {
          emit(MyAccountStateError(errorMessage: e.message));
        }
      }
    });
    on<DeleteMyArticleEvent>((event, emit) async {
      Author? author;
      List<Article>? articles;
      if (state is MyAccountStateSuccess) {
        author = (state as MyAccountStateSuccess).author;
        articles = (state as MyAccountStateSuccess).articles;
      }
      emit(MyAccountStateLoading());
      try {
        await _service.deleteArticle(event.id);
        emit(MyArticleStateDeleted());
        if (articles != null && author != null) {
          final newArticles =
              articles.where((article) => article.id != event.id).toList();
          final newAuthor = Author(
            id: author.id,
            firstName: author.firstName,
            lastName: author.lastName,
            about: author.about,
            image: author.image,
            numberOfPosts: author.numberOfPosts - 1,
            email: author.email,
          );
          emit(MyAccountStateSuccess(articles: newArticles, author: newAuthor));
        } else {
          add(GetMyAccountEvent());
        }
      } catch (e) {}
    });
    on<UnauthenticatedMyAccountEvent>((event, emit) {
      emit(
        MyAccountStateUnauthenticated(errorMessage: 'you are not Logged in'),
      );
    });
    on<UpdateMyAccountEvent>((event, emit) async {
      final articles = (state as MyAccountStateSuccess).articles;
      final oldAuthor = (state as MyAccountStateSuccess).author;
      emit(MyAccountStateLoading());
      try {
        final newAuthor = await _service.updateMyAccount(event.author);

        emit(
          MyAccountStateSuccess(
            articles: articles,
            author: Author(
              id: newAuthor.id,
              firstName: newAuthor.firstName,
              email: newAuthor.email ?? oldAuthor.email,
              lastName: newAuthor.lastName,
              about: newAuthor.about ?? oldAuthor.about,
              image: newAuthor.image,
              numberOfPosts: oldAuthor.numberOfPosts,
            ),
          ),
        );
      } on AppException catch (e) {
        emit(MyAccountStateError(errorMessage: e.message));
      }
    });
  }
}
