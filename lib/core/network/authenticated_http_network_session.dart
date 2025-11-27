import 'package:mobile_version/core/network/authenticated_dio_network_session.dart';
import 'package:mobile_version/core/network/network_session.dart';

class AuthenticatedHttpNetworkSession implements NetworkSession {
  final NetworkSession _networkSession;
  final GetTokenManager _manager;

  AuthenticatedHttpNetworkSession({
    required NetworkSession networkSession,
    required GetTokenManager manager,
  }) : _networkSession = networkSession,
       _manager = manager;

  @override
  Future get(String path, {Map<String, String> headers = const {}}) async {
    final token = await _manager.getToken();
    return _networkSession.get(
      path,
      headers: {
        "authorization": "bearer $token",
        "Content-Type": "application/json",
      },
    );
  }

  @override
  Future post(
    String path, {
    Map<String, String> headers = const {},
    Object? body,
  }) async {
    final token = await _manager.getToken();
    return _networkSession.post(
      path,
      headers: {
        "authorization": "bearer $token",
        "Content-Type": "application/json",
      },
      body: body,
    );
  }

  @override
  Future delete(String path, {Map<String, String> headers = const {}}) async {
    final token = await _manager.getToken();
    return _networkSession.delete(
      path,
      headers: {
        "authorization": "bearer $token",
        "Content-Type": "application/json",
      },
    );
  }
}
