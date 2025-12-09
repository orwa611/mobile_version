import 'package:flutter/material.dart';
import 'package:mobile_version/models/author_model.dart';
import 'package:mobile_version/pages/create_article/create_article_page.dart';

class CreateArticleWidget extends StatelessWidget {
  final Author author;
  const CreateArticleWidget({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Image.network(
            author.authorImageUrl,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(height: 40, width: 40, child: Icon(Icons.person));
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(CreateArticlePage.route);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text("What's on your mind?"),
            ),
          ),
        ),
      ],
    );
  }
}
