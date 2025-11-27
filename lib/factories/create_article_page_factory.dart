import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/my_account_bloc/my_account_bloc.dart';
import 'package:mobile_version/pages/create_article/create_article_notifier.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';
import 'package:mobile_version/services/pick_image_service.dart';

final class CreateArticlePageFactory {
  static Widget buildCreateArticlePage(BuildContext context) {
    return BlocBuilder<MyAccountBloc, MyAccountState>(
      builder: (context, state) {
        if (state is MyAccountStateSuccess) {
          return CreateArticlePage(
            author: state.author,
            notifier: CreateArticleNotifierImpl(
              globalKey: GlobalKey(),
              service: context.read<PickImageService>(),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
