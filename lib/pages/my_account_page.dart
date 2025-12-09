import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/widgets/article_list.dart';
import 'package:mobile_version/widgets/create_article_widget.dart';

class MyAccountPage extends StatelessWidget {
  final List<Article> articles;
  final Author author;
  final void Function(Article) onGoToArticle;
  final void Function(Author) onGoToEditProfile;
  final void Function(Article article) showActionsSheet;
  static const String route = '/myAccount';

  const MyAccountPage({
    super.key,
    required this.articles,
    required this.onGoToArticle,
    required this.author,
    required this.showActionsSheet,
    required this.onGoToEditProfile,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      author.fullName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onGoToEditProfile(author);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
                Text(author.about),
                Text('Published post: ${author.numberOfPosts}'),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: CreateArticleWidget(author: author),
                ),
                Divider(),
              ],
            ),
          ),
          ArticleList(
            articles: articles,
            onGoToArticle: onGoToArticle,
            shouldDisplayActions: true,
            onTapActionsButton: (article) {
              showActionsSheet(article);
            },
            authorId: author.id,
          ),
        ],
      ),
    );
  }
}
