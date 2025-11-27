import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/login_response.dart';

abstract class AuthService {
  Future<LoginResponse> login(String email, String password);
}

class AuthServiceImpl implements AuthService {
  final NetworkSession session;

  AuthServiceImpl({required this.session});

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final result = await session.post(
        '/author/login',
        body: {'email': email, 'password': password},
      );
      return LoginResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }
}
