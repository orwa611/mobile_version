import 'package:mobile_version/models/article_detail_model.dart';
import 'package:mobile_version/models/article_model.dart';
import 'package:mobile_version/models/comment_model.dart';

class AllArticleResponse {
  final List<ArticleResponse> articles;
  final int page;
  final int limit;
  final int totalArticles;
  final int totalPages;

  factory AllArticleResponse.fromJson(Map<String, dynamic> json) {
    final articlesRes = json['articles'] as List<dynamic>;
    final List<ArticleResponse> articlesResponse =
        articlesRes.map((e) => ArticleResponse.fromJson(e)).toList();
    final pageRes = json['page'] as int;
    final limitRes = json['limit'] as int;
    final totalArticlesRes = json['totalArticles'] as int;
    final totalPagesRes = json['totalPages'] as int;
    return AllArticleResponse(
      articles: articlesResponse,
      page: pageRes,
      limit: limitRes,
      totalArticles: totalArticlesRes,
      totalPages: totalPagesRes,
    );
  }

  AllArticleResponse({
    required this.articles,
    required this.page,
    required this.limit,
    required this.totalArticles,
    required this.totalPages,
  });
}

class ArticleResponse {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String status;
  final String date;
  final String image;
  final AuthorResponse? author;

  ArticleResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.status,
    required this.date,
    required this.image,
    required this.author,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final titleRes = json['title'] as String;
    final contentRes = json['content'] as String;
    final tagsRes = json['tags'] as List<dynamic>;
    final statusRes = json['status'] as String;
    final dateRes = json['date'] as String;
    final imageRes = json['image'] as String;
    final authorRes = json['author'] as dynamic;
    return ArticleResponse(
      id: idRes,
      title: titleRes,
      content: contentRes,
      tags: tagsRes.map((e) => e as String).toList(),
      status: statusRes,
      date: dateRes,
      image: imageRes,
      author: AuthorResponse.fromJson(authorRes),
    );
  }

  factory ArticleResponse.fromJsonMyAccount(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final titleRes = json['title'] as String;
    final contentRes = json['content'] as String;
    final tagsRes = json['tags'] as List<dynamic>;
    final statusRes = json['status'] as String;
    final dateRes = json['date'] as String;
    final imageRes = json['image'] as String;
    return ArticleResponse(
      id: idRes,
      title: titleRes,
      content: contentRes,
      tags: tagsRes.map((e) => e as String).toList(),
      status: statusRes,
      date: dateRes,
      image: imageRes,
      author: null,
    );
  }
  // ?????
  Article toArticle() {
    return Article(
      id: id,
      authorId: author?.id ?? "",
      title: title,
      description: content,
      firstName: author?.firstName ?? "",
      lastName: author?.lastName ?? "",
      createdAt: date,
      articleImage: image,
      authorImage: author?.image ?? "",
    );
  }
}

class AuthorResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String image;
  final String? about;

  AuthorResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    this.about,
  });

  factory AuthorResponse.fromJson(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final firstNameRes = json['name'] as String;
    final lastNameRes = json['lastname'] as String;
    final imageRes = json['image'] as String;
    final aboutRes = json['about'] as String?;
    return AuthorResponse(
      id: idRes,
      firstName: firstNameRes,
      lastName: lastNameRes,
      image: imageRes,
      about: aboutRes,
    );
  }
}

class CommentResponse {
  final String id;
  final AuthorResponse author;
  final String date;
  final String content;

  CommentResponse({
    required this.id,
    required this.author,
    required this.date,
    required this.content,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final authorRes = json['refAuthor'] as dynamic;
    final dateRes = json['createdAt'] as String;
    final contentRes = json['content'] as String;
    return CommentResponse(
      id: idRes,
      author: AuthorResponse.fromJson(authorRes),
      date: dateRes,
      content: contentRes,
    );
  }

  CommentModel toModel() {
    return CommentModel(
      id: id,
      content: content,
      firstName: author.firstName,
      lastName: author.lastName,
      authorImage: author.image,
      date: date,
    );
  }
}

class DetailArticleResponse {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String status;
  final String date;
  final String image;
  final AuthorResponse author;
  final List<CommentResponse> comments;

  DetailArticleResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.status,
    required this.date,
    required this.image,
    required this.author,
    required this.comments,
  });

  factory DetailArticleResponse.fromJson(Map<String, dynamic> json) {
    final idRes = json['_id'] as String;
    final titleRes = json['title'] as String;
    final contentRes = json['content'] as String;
    final tagsRes = json['tags'] as List<dynamic>;
    final statusRes = json['status'] as String;
    final dateRes = json['date'] as String;
    final imageRes = json['image'] as String;
    final authorRes = json['author'] as dynamic;
    final commentsRes = json['comments'] as List<dynamic>;
    return DetailArticleResponse(
      id: idRes,
      title: titleRes,
      content: contentRes,
      tags: tagsRes.map((e) => e as String).toList(),
      status: statusRes,
      date: dateRes,
      image: imageRes,
      author: AuthorResponse.fromJson(authorRes),
      comments: commentsRes.map((e) => CommentResponse.fromJson(e)).toList(),
    );
  }
  ArticleDetail toArticleDetail() {
    return ArticleDetail(
      id: id,
      title: title,
      description: content,
      firstName: author.firstName,
      lastName: author.lastName,
      createdAt: date,
      articleImage: image,
      authorImage: author.image,
      comments: comments.map((e) => e.toModel()).toList(),
      tags: tags,
    );
  }
}
