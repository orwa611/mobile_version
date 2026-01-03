import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/widgets/article_list.dart';

class AuthorPage extends StatelessWidget {
  static const String route = '/author';
  final List<Article> articles;
  final Author author;
  final void Function(Article) onGoToArticle;
  final String authorId;
  final void Function(bool, Article) onTapFavButton;
  final List<Article> Function() getArticlesFav;

  const AuthorPage({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    required this.authorId,
    required this.onTapFavButton,
    required this.getArticlesFav,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.network(
                  author.authorImageUrl,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 120,
                      width: 120,
                      child: Icon(Icons.person),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    author.fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(author.about),
              Text('Published post: ${author.numberOfPosts}'),

              Divider(),
            ],
          ),
        ),

        ArticleList(
          articles: articles,
          onGoToArticle: onGoToArticle,
          shouldDisplayActions: false,
          onTapAuthorButton: (authorId) {},
          authorId: authorId,
          onTapFavButton: onTapFavButton,
          getArticlesFav: getArticlesFav,
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10)),
      ],
    );
  }
}
