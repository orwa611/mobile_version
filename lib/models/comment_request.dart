class CommentRequest {
  final String content;
  final String commenterId;

  CommentRequest({required this.content, required this.commenterId});

  Map<String, dynamic> toJson() {
    return {'content': content};
  }
}
