import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/widgets/article_list.dart';

class MyAccountPage extends StatelessWidget {
  final List<Article> articles;
  final Author author;
  final void Function(Article) onGoToArticle;
  final void Function(String id) showActionsSheet;
  static const String route = '/myAccount';

  const MyAccountPage({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    required this.author,
    required this.showActionsSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                Text(
                  'Jhon Doe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('Bio/about'),
                Text('Published post: ${author.numberOfPosts}'),
              ],
            ),
          ),
          ArticleList(
            articles: articles,
            onGoToArticle: onGoToArticle,
            shouldDisplayActions: true,
            onTapActionsButton: (article) {
              showActionsSheet(article.id);
            },
          ),
        ],
      ),
    );
  }
}
