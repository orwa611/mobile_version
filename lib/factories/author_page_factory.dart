import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/article_detail_bloc.dart/article_detail_bloc.dart';
import 'package:mobile_version/blocs/author_bloc/author_bloc.dart';
import 'package:mobile_version/blocs/author_bloc/author_state.dart';
import 'package:mobile_version/blocs/favorites_bloc/favorites_bloc.dart';
import 'package:mobile_version/pages/article_page.dart';
import 'package:mobile_version/pages/author_page.dart';
import 'package:mobile_version/widgets/loading_widget.dart';

final class AuthorPageFactory {
  static Widget buildAuthorPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthorBloc, AuthorState>(
        builder: (context, authorState) {
          if (authorState is AuthorErrorState) {
            return Center(child: Text(authorState.errorMessage));
          }
          if (authorState is AuthorLoadingState) {
            return LoadingWidget();
          }
          if (authorState is AuthorSuccessState) {
            return BlocBuilder<FavoritesBloc, FavoritesBlocState>(
              builder: (context, favState) {
                if (favState is FavoritesStateLoading) {
                  return LoadingWidget();
                }
                return AuthorPage(
                  articles: authorState.articles,
                  onGoToArticle: (article) {
                    context.read<ArticleDetailBloc>().add(
                      GetArticleDetailEvent(id: article.id),
                    );
                    Navigator.of(context).pushNamed(ArticlePage.route);
                  },
                  authorId: authorState.author.id,
                  onTapFavButton: (value, article) {
                    if (value) {
                      context.read<FavoritesBloc>().add(
                        UnFavoriteArticleEvent(article: article),
                      );
                    } else {
                      context.read<FavoritesBloc>().add(
                        FavoriteArticleEvent(article: article),
                      );
                    }
                  },
                  getArticlesFav: () {
                    if (favState is ListFavoritesStateSuccess) {
                      return favState.favArticles;
                    } else {
                      return [];
                    }
                  },
                  author: authorState.author,
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
