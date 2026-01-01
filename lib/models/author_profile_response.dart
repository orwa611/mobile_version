import 'package:mobile_version/models/author_model.dart';

class AuthorProfileResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String image;
  final String email;
  final String about;
  final int publishedPosts;

  AuthorProfileResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.about,
    required this.publishedPosts,
  });

  factory AuthorProfileResponse.fromJson(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final firstNameRes = json['name'] as String;
    final lastNameRes = json['lastname'] as String;
    final imageRes = json['image'] as String;
    final emailRes = json['email'] as String;
    final aboutRes = json['about'] as String;
    final publishedPostsRes = json['publishedPosts'] as int;
    return AuthorProfileResponse(
      id: idRes,
      firstName: firstNameRes,
      lastName: lastNameRes,
      image: imageRes,
      about: aboutRes,
      email: emailRes,
      publishedPosts: publishedPostsRes,
    );
  }

  Author toAuthorModel() {
    return Author(
      firstName: firstName,
      email: lastName,
      id: id,
      lastName: lastName,
      about: about,
      image: image,
      numberOfPosts: publishedPosts,
    );
  }
}
