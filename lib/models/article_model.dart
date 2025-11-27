import 'package:mobile_version/core/constants/network_constants.dart';

class Article {
  final String id;
  final String title;
  final String description;
  final String firstName;
  final String lastName;
  final String authorId;
  final String createdAt;
  final String articleImage;
  final String authorImage;

  Article({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.articleImage,
    required this.authorImage,
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
