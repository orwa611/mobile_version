import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/create_article_bloc/create_article_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/core/extensions/context_extension.dart';
import 'package:mobile_version/pages/create_article/create_article_notifier.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/pages/my_account_page.dart';
import 'package:mobile_version/services/pick_image_service.dart';

final class CreateArticlePageFactory {
  static Widget buildCreateArticlePage(BuildContext context) {
    return BlocBuilder<MyAccountBloc, MyAccountState>(
      builder: (context, myAccountState) {
        if (myAccountState is MyAccountStateSuccess) {
          return BlocConsumer<CreateArticleBloc, CreateArticleState>(
            listener: (context, createArticleState) {
              if (createArticleState is CreateArticleErrorState) {
                context.snackBar(
                  createArticleState.errorMessage,
                  status: SnackBarStatus.error,
                );
              }
              if (createArticleState is CreateArticleSuccessState) {
                context.read<MyAccountBloc>().add(GetMyAccountEvent());
                context.snackBar(
                  'Article Created Successfully, wait for APPROVAL!',
                );
              }
            },
            builder: (context, createArticleState) {
              if (createArticleState is CreateArticleLoadingState) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              return CreateArticlePage(
                onShare: (request) {
                  context.read<CreateArticleBloc>().add(
                    ShareArticleEvent(request: request),
                  );
                },
                author: myAccountState.author,
                notifier: CreateArticleNotifierImpl(
                  globalKey: GlobalKey(),
                  service: context.read<PickImageService>(),
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
