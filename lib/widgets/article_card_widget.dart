import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';

class ArticleCardWidget extends StatelessWidget {
  final Article article;
  final VoidCallback? onGoToArticle;
  final VoidCallback? onTapActionsButton;
  final VoidCallback? onTapAuthorButton;
  final bool shouldDisplayActions;

  const ArticleCardWidget({
    super.key,
    required this.article,
    this.onGoToArticle,
    this.shouldDisplayActions = false,
    this.onTapActionsButton,
    this.onTapAuthorButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGoToArticle,
      child: Card(
        color: const Color.fromARGB(255, 255, 243, 249),
        shadowColor: Colors.grey.shade200,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                article.articleImageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 200,
                    child: Center(child: Icon(Icons.warning_amber)),
                  );
                },
              ),
              Text(article.title),
              Text(article.shortDescription),
              Row(
                children: [
                  shouldDisplayActions
                      ? _buildActionsIconButton()
                      : _buildAuthorIconButton(),
                  Spacer(),
                  Text('created at ${article.formatedCreatedAt}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorIconButton() {
    return IconButton(
      onPressed: onTapAuthorButton,
      icon: Row(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              article.authorImageUrl,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(Icons.person),
                );
              },
            ),
          ),
          Text(article.fullName),
        ],
      ),
    );
  }

  Widget _buildActionsIconButton() {
    return IconButton(
      onPressed: onTapActionsButton,
      icon: Icon(Icons.more_horiz),
    );
  }
}
