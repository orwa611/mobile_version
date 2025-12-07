import 'package:mobile_version/core/constants/network_constants.dart';

class Author {
  final String id;
  final String firstName;
  final String lastName;
  final String about;
  final String image;
  final String email;
  final int numberOfPosts;

  Author({
    required this.firstName,
    required this.email,
    required this.id,
    required this.lastName,
    required this.about,
    required this.image,
    required this.numberOfPosts,
  });
  String get authorImageUrl => '${NetworkConstants.baseUrl}/image/$image';
  String get fullName => '$firstName $lastName';
}
