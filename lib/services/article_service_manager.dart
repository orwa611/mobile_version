import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/article_request.dart';
import 'package:mobile_version/models/article_response.dart';

abstract class ArticleServiceManager {
  Future<ArticleResponse> createArticle(ArticleRequest request);
}

class ArticleServiceManagerImpl implements ArticleServiceManager {
  final NetworkSession _session;

  ArticleServiceManagerImpl({required NetworkSession session})
    : _session = session;
  @override
  Future<ArticleResponse> createArticle(ArticleRequest request) async {
    try {
      final result = await _session.post(
        '/article/add',
        body: request.toFormData(),
      );
      return ArticleResponse.fromJsonMyAccount(result);
    } on NetworkException catch (e) {
      throw e.toAppException();
    }
  }
}
