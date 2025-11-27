import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/register_request.dart';
import 'package:mobile_version/models/register_response.dart';

abstract class RegisterService {
  Future<RegisterResponse> register(RegisterRequest request);
}

class RegisterServiceImpl implements RegisterService {
  final NetworkSession session;

  RegisterServiceImpl({required this.session});
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final result = await session.post(
        '/author/register',
        body: request.toJson(),
      );
      return RegisterResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }
}
