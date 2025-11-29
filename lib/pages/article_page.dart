import 'package:flutter/material.dart';
import 'package:mobile_version/models/article_detail_model.dart';
import 'package:mobile_version/widgets/comment_input_widget.dart';
import 'package:mobile_version/widgets/comments_widget.dart';

class ArticlePage extends StatelessWidget {
  final ArticleDetail article;
  static const String route = '/article';
  final Function(String) onSend;

  const ArticlePage({super.key, required this.article, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: const Color.fromARGB(255, 255, 243, 249),
                  shadowColor: Colors.grey.shade200,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
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
                        Text(article.description),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
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
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
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
                            ),

                            Spacer(),
                            Text('created at ${article.formatedCreatedAt}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    spacing: 10,
                    children:
                        article.tags.map((e) => Chip(label: Text(e))).toList(),
                  ),
                ),
                Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    children:
                        article.comments.map((comment) {
                          return CommentsWidget(comment: comment);
                        }).toList(),
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CommentInputWidget(onSend: onSend),
          ),
        ],
      ),
    );
  }
}
