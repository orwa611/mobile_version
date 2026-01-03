import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/article_detail_bloc.dart/article_detail_bloc.dart';
import 'package:mobile_version/blocs/comment_bloc.dart/comment_bloc.dart';
import 'package:mobile_version/blocs/user_bloc/user_bloc.dart';
import 'package:mobile_version/core/extensions/context_extension.dart';
import 'package:mobile_version/pages/article_page.dart';
import 'package:mobile_version/widgets/app_error_widget.dart';
import 'package:mobile_version/widgets/loading_widget.dart';

final class ArticlePageFactory {
  static Widget buildArticlePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
        builder: (context, state) {
          if (state is ArticleDetailStateLoading) {
            return LoadingWidget();
          }
          if (state is ArticleDetailStateError) {
            return AppErrorWidget(
              message: state.errorMessage,
              onRefresh: () {
                final id =
                    ModalRoute.of(context)?.settings.arguments as String?;
                if (id != null) {
                  context.read<ArticleDetailBloc>().add(
                    GetArticleDetailEvent(id: id),
                  );
                }
              },
            );
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
                  if (context.read<UserBloc>().state is UserStateLoggedIn) {
                    context.read<CommentBloc>().add(
                      AddToDbCommentEvent(
                        id: state.article.id,
                        comment: comment,
                      ),
                    );
                  } else {
                    context.snackBar(
                      'you cant add comment! you need to login.',
                      status: SnackBarStatus.info,
                    );
                  }
                },
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
