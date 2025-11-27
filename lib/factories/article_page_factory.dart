import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/article_detail_bloc.dart/article_detail_bloc.dart';
import 'package:mobile_version/blocs/comment_bloc.dart/comment_bloc.dart';
import 'package:mobile_version/pages/article_page.dart';

final class ArticlePageFactory {
  static Widget buildArticlePage(BuildContext context) {
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      builder: (context, state) {
        if (state is ArticleDetailStateLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is ArticleDetailStateError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is ArticleDetailStateSuccess) {
          return BlocListener<CommentBloc, CommentState>(
            listener: (context, state) {
              if (state is CommentStateSuccess) {
                context.read<ArticleDetailBloc>().add(
                  AddCommentToArticleEvent(comment: state.comment),
                );
              }
            },
            child: ArticlePage(
              article: state.article,
              onSend: (comment) {
                context.read<CommentBloc>().add(
                  AddToDbCommentEvent(id: state.article.id, comment: comment),
                );
              },
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
