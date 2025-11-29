import 'package:mobile_version/core/constants/network_constants.dart';
import 'package:mobile_version/models/comment_model.dart';

class ArticleDetail {
  final String id;
  final String title;
  final String description;
  final String firstName;
  final String lastName;
  final String createdAt;
  final String articleImage;
  final String authorImage;
  final List<CommentModel> comments;
  final List<String> tags;

  ArticleDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.articleImage,
    required this.authorImage,
    required this.comments,
    required this.tags,
  });
  String get fullName => '$firstName $lastName';

  String get articleImageUrl =>
      '${NetworkConstants.baseUrl}/image/$articleImage';

  String get authorImageUrl => '${NetworkConstants.baseUrl}/image/$authorImage';

  String get shortDescription => '${description.substring(0, 255)}...';

  String get formatedCreatedAt {
    final splited = createdAt.split('T');
    final min = splited[1].split(':');
    return '${splited[0]} ${min[0]}:${min[1]}';
  }
}
