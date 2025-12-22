import 'package:flutter/material.dart';
import 'package:mobile_version/core/constants/logo_constants.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/widgets/app_text_button.dart';
import 'package:mobile_version/widgets/article_list.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';
  final VoidCallback? onGoToLogin;
  final VoidCallback? onLogout;
  final bool isLoggedIn;
  final List<Article> articles;
  final void Function(Article) onGoToArticle;
  final void Function(String id) onGoToAuthor;
  final Widget Function() authorBuilder;
  final String Function()? getAuthorId;
  final List<Article> Function() getArticlesFav;
  final ScrollController? controller;
  final Future<void> Function() onRefresh;

  final void Function(bool, Article) onTapFavButton;

  const HomePage({
    super.key,
    required this.onGoToLogin,
    required this.isLoggedIn,
    required this.onLogout,
    required this.articles,
    required this.onGoToArticle,
    required this.onGoToAuthor,
    required this.authorBuilder,
    this.getAuthorId,
    required this.onTapFavButton,
    required this.getArticlesFav,
    this.controller,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: onRefresh,
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverAppBar(
              pinned: true,
              scrolledUnderElevation: 0,
              expandedHeight: 20.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(LogoConstants.logo),
              ),
              actions: [_buildActionButtons()],
            ),
            SliverToBoxAdapter(child: authorBuilder()),
            ArticleList(
              articles: articles,
              onGoToArticle: onGoToArticle,
              shouldDisplayActions: false,
              onTapAuthorButton: (article) {
                onGoToAuthor(article.authorId);
              },
              authorId: getAuthorId != null ? getAuthorId!() : '',
              onTapFavButton: onTapFavButton,
              getArticlesFav: getArticlesFav,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() =>
      isLoggedIn
          ? AppTextButton(label: 'Sign out', onPressed: onLogout)
          : AppTextButton(label: 'Sign in', onPressed: onGoToLogin);
}
