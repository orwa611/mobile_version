import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/form_article_bloc/form_article_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/core/extensions/context_extension.dart';
import 'package:mobile_version/pages/create_article/create_article_notifier.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/services/pick_image_service.dart';
import 'package:mobile_version/widgets/loading_widget.dart';

final class CreateArticlePageFactory {
  static Widget buildCreateArticlePage(BuildContext context) {
    return BlocBuilder<MyAccountBloc, MyAccountState>(
      builder: (context, myAccountState) {
        if (myAccountState is MyAccountStateSuccess) {
          return BlocConsumer<FormArticleBloc, FormArticleState>(
            listener: (context, createArticleState) {
              if (createArticleState is FormArticleErrorState) {
                context.snackBar(
                  createArticleState.errorMessage,
                  status: SnackBarStatus.error,
                );
              }
              if (createArticleState is FormArticleSuccessState) {
                context.read<MyAccountBloc>().add(GetMyAccountEvent());
                context.snackBar(
                  'Article Created Successfully, wait for APPROVAL!',
                );
                Navigator.of(context).pop();
              }
            },
            builder: (context, createArticleState) {
              if (createArticleState is FormArticleLoadingState) {
                return LoadingWidget();
              }
              return CreateArticlePage(
                onShare: (request) {
                  context.read<FormArticleBloc>().add(
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
