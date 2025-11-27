import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/widgets/article_card_widget.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articles;
  final void Function(Article) onGoToArticle;
  final void Function(Article)? onTapActionsButton;
  final void Function(Article)? onTapAuthorButton;
  final bool shouldDisplayActions;

  const ArticleList({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    this.onTapActionsButton,
    this.onTapAuthorButton,
    required this.shouldDisplayActions,
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
        );
      }, childCount: articles.length),
    );
  }
}
