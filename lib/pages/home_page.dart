import 'package:flutter/material.dart';
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

  const HomePage({
    super.key,
    required this.onGoToLogin,
    required this.isLoggedIn,
    required this.onLogout,
    required this.articles,
    required this.onGoToArticle,
    required this.onGoToAuthor,
    required this.authorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0,
            expandedHeight: 20.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('logo.png'),
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
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() =>
      isLoggedIn
          ? AppTextButton(label: 'Sign out', onPressed: onLogout)
          : AppTextButton(label: 'Sign in', onPressed: onGoToLogin);
}
