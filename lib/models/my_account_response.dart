import 'package:mobile_version/models/article_response.dart';
import 'package:mobile_version/models/author_model.dart';

class MyAccountResponse {
  final AuthorResponse author;
  final List<ArticleResponse> articles;
  final int publishedPosts;

  factory MyAccountResponse.fromJson(Map<String, dynamic> json) {
    final articlesRes = json['articles'] as List<dynamic>;
    final List<ArticleResponse> list =
        articlesRes.map((e) => ArticleResponse.fromJsonMyAccount(e)).toList();
    final authorRes = AuthorResponse.fromJson(json);
    final publishedPostsRes = json['publishedPosts'] as int;
    return MyAccountResponse(
      author: authorRes,
      articles: list,
      publishedPosts: publishedPostsRes,
    );
  }

  MyAccountResponse({
    required this.author,
    required this.articles,
    required this.publishedPosts,
  });

  Author toAuthor() {
    return Author(
      firstName: author.firstName,
      lastName: author.lastName,
      about: author.about ?? '',
      image: author.image,
      numberOfPosts: publishedPosts,
    );
  }
}
