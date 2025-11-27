import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/article_response.dart';

abstract class ArticleService {
  Future<AllArticleResponse> getArticles();
  Future<DetailArticleResponse> getArticle(String id);
}

final class ArticleServiceImpl implements ArticleService {
  final NetworkSession _session;

  ArticleServiceImpl({required NetworkSession session}) : _session = session;

  @override
  Future<AllArticleResponse> getArticles() async {
    try {
      final result = await _session.get('/article/all');
      return AllArticleResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }

  @override
  Future<DetailArticleResponse> getArticle(String id) async {
    try {
      final result = await _session.get('/article/getbyid/$id');
      return DetailArticleResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }
}
