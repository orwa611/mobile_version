import 'package:dio/dio.dart';
import 'package:mobile_version/core/constants/network_constants.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/error_response.dart';

abstract class GetTokenManager {
  Future<String> getToken();
}

final class DioNetworkSession implements NetworkSession {
  final Dio dio;

  DioNetworkSession({required this.dio, required GetTokenManager manager}) {
    dio.options.baseUrl = NetworkConstants.baseUrl;
    dio.interceptors.add(AuthorizationInterceptor(manager: manager));
    dio.options.connectTimeout = Duration(seconds: 20);
    dio.options.receiveTimeout = Duration(seconds: 30);
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, String> headers = const {},
  }) {
    throw UnimplementedError();
  }

  @override
  Future get(
    String path, {
    Map<String, String> headers = const {"Content-Type": "application/json"},
  }) async {
    try {
      final response = await dio.get(path, options: Options(headers: headers));
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return response.data;
      } else {
        throw HttpResponseException(
          url: path,
          errorResponse: ErrorResponse.fromJson(response.data),
          statusCode: response.statusCode ?? -1,
        );
      }
    } on HttpResponseException catch (_) {
      rethrow;
    } catch (_) {
      throw ServerException(url: path);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, String> headers = const {},
    Object? body,
  }) async {
    try {
      final response = await dio.post(
        path,
        options: Options(headers: headers),
        data: body,
      );
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return response.data;
      } else {
        throw HttpResponseException(
          url: path,
          errorResponse: ErrorResponse.fromJson(response.data),
          statusCode: response.statusCode ?? -1,
        );
      }
    } on HttpResponseException catch (_) {
      rethrow;
    } catch (_) {
      throw ServerException(url: path);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, String> headers = const {},
    Object? body,
  }) async {
    try {
      final response = await dio.put(
        path,
        options: Options(headers: headers),
        data: body,
      );
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return response.data;
      } else {
        throw HttpResponseException(
          url: path,
          errorResponse: ErrorResponse.fromJson(response.data),
          statusCode: response.statusCode ?? -1,
        );
      }
    } on HttpResponseException catch (_) {
      rethrow;
    } catch (_) {
      throw ServerException(url: path);
    }
  }
}

final class AuthorizationInterceptor extends Interceptor {
  final GetTokenManager _manager;

  AuthorizationInterceptor({required GetTokenManager manager})
    : _manager = manager;
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _manager.getToken();
    if (token.isNotEmpty) {
      options.headers['authorization'] = 'bearer $token';
    }
    return handler.next(options);
  }
}
