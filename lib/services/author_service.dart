import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/article_response.dart';
import 'package:mobile_version/models/author_profile_response.dart';

abstract class AuthorService {
  Future<AuthorProfileResponse> getAuthorProfile(String id);
  Future<List<ArticleResponse>> getAuthorArticles(String authorId);
}

class AuthorServiceImpl extends AuthorService {
  final NetworkSession _session;

  AuthorServiceImpl({required NetworkSession session}) : _session = session;

  @override
  Future<AuthorProfileResponse> getAuthorProfile(String id) async {
    try {
      final result = await _session.get('/author/id/$id');
      return AuthorProfileResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw e.toAppException();
    }
  }

  @override
  Future<List<ArticleResponse>> getAuthorArticles(String authorId) async {
    try {
      final List<dynamic> result = await _session.get(
        '/article/author/$authorId',
      );
      return result.map((e) => ArticleResponse.fromJsonMyAccount(e)).toList();
    } on NetworkException catch (e) {
      throw e.toAppException();
    }
  }
}
