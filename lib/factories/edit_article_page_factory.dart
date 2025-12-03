import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/create_article_bloc/create_article_bloc.dart';
import 'package:mobile_version/blocs/edit_article_bloc.dart/edit_article_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/pages/create_article/edit_article_notifier_impl.dart';
import 'package:mobile_version/services/pick_image_service.dart';

final class EditArticlePageFactory {
  static const String route = '/edit';
  static Widget buildEditArticlePage(BuildContext context) {
    return BlocBuilder<MyAccountBloc, MyAccountState>(
      builder: (context, myAccountState) {
        if (myAccountState is MyAccountStateSuccess) {
          return BlocBuilder<EditArticleBloc, EditArticleState>(
            builder: (context, editState) {
              if (editState is EditArticleSuccessState) {
                final article = editState.article;
                final notifier = EditArticleNotifierImpl(
                  imageUrl: article.articleImageUrl,
                  globalKey: GlobalKey<FormState>(),
                  service: context.read<PickImageService>(),
                  request: ArticleRequest(
                    title: article.title,
                    content: article.description,
                    tags: article.tags,
                    image: [],
                  ),
                );
                return CreateArticlePage(
                  author: myAccountState.author,
                  notifier: notifier,

                  onShare: (request) {
                    context.read<CreateArticleBloc>().add(
                      ShareArticleEvent(request: request),
                    );
                  },
                  isEdit: true,
                );
              }
              return SizedBox.shrink();
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
