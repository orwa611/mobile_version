import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/widgets/article_list.dart';

class FavoritesPage extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onGoToArticle;
  final void Function(String id) onGoToAuthor;
  final String Function()? getAuthorId;
  final void Function(bool, Article) onTapFavButton;
  final List<Article> Function() getArticlesFav;

  const FavoritesPage({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    required this.onGoToAuthor,
    this.getAuthorId,
    required this.onTapFavButton,
    required this.getArticlesFav,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ArticleList(
            articles: articles,
            onGoToArticle: onGoToArticle,
            shouldDisplayActions: false,
            onTapAuthorButton: (p0) {},
            authorId: getAuthorId != null ? getAuthorId!() : '',
            onTapFavButton: onTapFavButton,
            getArticlesFav: getArticlesFav,
          ),
        ],
      ),
    );
  }
}
