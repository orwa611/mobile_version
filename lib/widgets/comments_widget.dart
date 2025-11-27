import 'package:flutter/material.dart';
import 'package:mobile_version/models/comment_model.dart';

class CommentsWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentsWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            comment.authorImageUrl,
            height: 30,
            width: 30,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SizedBox(height: 30, width: 30, child: Icon(Icons.person));
            },
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  comment.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  comment.formatedCreatedAt,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                ),
              ],
            ),
            Text(comment.content),
          ],
        ),
      ],
    );
  }
}
