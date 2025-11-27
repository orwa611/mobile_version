import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/article_response.dart';
import 'package:mobile_version/models/my_account_response.dart';

abstract class AccountService {
  Future<MyAccountResponse> getMyAccount();
  Future<ArticleResponse> deleteArticle(String id);
}

class AccountServiceImpl implements AccountService {
  final NetworkSession _session;

  AccountServiceImpl({required NetworkSession session}) : _session = session;

  @override
  Future<MyAccountResponse> getMyAccount() async {
    try {
      final result = await _session.get('/author/account');
      return MyAccountResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw e.toAppException();
    }
  }

  @override
  Future<ArticleResponse> deleteArticle(String id) async {
    try {
      final result = await _session.delete('/article/delete/$id');
      return ArticleResponse.fromJsonMyAccount(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }
}
