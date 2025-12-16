import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/widgets/article_card_widget.dart';
import 'package:mobile_version/widgets/article_status_widget.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onGoToArticle;
  final void Function(Article)? onTapActionsButton;
  final void Function(Article)? onTapAuthorButton;
  final bool shouldDisplayActions;
  final String authorId;
  final void Function(bool, Article) onTapFavButton;
  final List<Article> Function() getArticlesFav;
  const ArticleList({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    this.onTapActionsButton,
    this.onTapAuthorButton,
    required this.shouldDisplayActions,
    required this.authorId,
    required this.onTapFavButton,
    required this.getArticlesFav,
  }) : assert(
         shouldDisplayActions
             ? onTapActionsButton != null
             : onTapAuthorButton != null,
       );

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ArticleCardWidget(
          article: articles[index],
          onGoToArticle: () {
            onGoToArticle(articles[index]);
          },
          shouldDisplayActions: shouldDisplayActions,

          onTapActionsButton: () {
            if (onTapActionsButton != null) {
              onTapActionsButton!(articles[index]);
            }
          },
          onTapAuthorButton: () {
            if (onTapAuthorButton != null) {
              onTapAuthorButton!(articles[index]);
            }
          },
          buildBadge: () {
            if (articles[index].authorId == authorId) {
              return ArticleStatusWidget(status: articles[index].statusBar);
            } else {
              return SizedBox.shrink();
            }
          },
          buildFavButton: (article) {
            if (getArticlesFav().map((e) => e.id).contains(article.id)) {
              return IconButton(
                onPressed: () {
                  onTapFavButton(true, article);
                },
                icon: Icon(Icons.favorite),
              );
            } else {
              return IconButton(
                onPressed: () {
                  onTapFavButton(false, article);
                },
                icon: Icon(Icons.favorite_border_outlined),
              );
            }
          },
        );
      }, childCount: articles.length),
    );
  }
}
