import 'package:flutter/material.dart';

class AuthorPictureWidget extends StatelessWidget {
  final double height;
  final double width;
  final String authorImage;

  const AuthorPictureWidget({
    super.key,
    required this.height,
    required this.width,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(120),
      child: Image.network(
        authorImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(height: 30, width: 30, child: Icon(Icons.person));
        },
      ),
    );
  }
}
