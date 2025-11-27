import 'package:mobile_version/core/constants/network_constants.dart';

class CommentModel {
  final String id;
  final String content;
  final String firstName;
  final String lastName;
  final String authorImage;
  final String date;

  CommentModel({
    required this.id,
    required this.content,
    required this.firstName,
    required this.lastName,
    required this.authorImage,
    required this.date,
  });
  String get fullName => '$firstName $lastName';
  String get authorImageUrl => '${NetworkConstants.baseUrl}/image/$authorImage';

  String get formatedCreatedAt {
    final splited = date.split('T');
    if (splited.isNotEmpty && splited.length == 2) {
      final min = splited[1].split(':');
      if (min.isNotEmpty && splited.length >= 2) {
        return '${splited[0]} ${min[0]}:${min[1]}';
      }
    }
    return date;
  }
}
