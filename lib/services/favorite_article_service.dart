import 'package:mobile_version/core/exceptions/app_data_base_exception.dart';

import '../core/storage/fav_db.dart';
import '../models/article_model.dart';

abstract class FavoriteArticleService {
  Future<bool> insertArticle({required Article article});
  Future<List<Article>> getArticles();
  Future<bool> removeArticle({required Article article});
}

final class FavoriteArticleServiceImpl implements FavoriteArticleService {
  AppDataBase appDataBase;

  FavoriteArticleServiceImpl(this.appDataBase);

  @override
  Future<bool> insertArticle({required Article article}) async {
    try {
      await appDataBase.insert("article", {
        "id": article.id,
        "title": article.title,
        "content": article.description,
        "article_image": article.articleImage,
        "created_at": article.createdAt,
        "author_id": article.authorId,
        "author_first_name": article.firstName,
        "author_last_name": article.lastName,
        "author_image": article.authorImage,
      });
      return true;
    } on AppDataBaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  @override
  Future<List<Article>> getArticles() async {
    try {
      final data = await appDataBase.query('article');
      return data.map((elem) {
        final id = elem['id'] as String;
        final authorId = elem['author_id'] as String;
        final title = elem['title'] as String;
        final description = elem['content'] as String;
        final firstName = elem['author_first_name'] as String;
        final lastName = elem['author_last_name'] as String;
        final createdAt = elem['created_at'] as String;
        final articleImage = elem['article_image'] as String;
        final authorImage = elem['author_image'] as String;
        return Article(
          id: id,
          authorId: authorId,
          title: title,
          description: description,
          tags: [],
          status: '',
          firstName: firstName,
          lastName: lastName,
          createdAt: createdAt,
          articleImage: articleImage,
          authorImage: authorImage,
        );
      }).toList();
    } on AppDataBaseException catch (e) {
      print(e.message);
      return [];
    }
  }

  @override
  Future<bool> removeArticle({required Article article}) async {
    try {
      await appDataBase.delete('article', where: {'id': article.id});
      return true;
    } on AppDataBaseException catch (e) {
      print(e.message);
      return false;
    }
  }
}
