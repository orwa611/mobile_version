import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/error_response.dart';

abstract class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  AppException toAppException();
}

class ServerException implements NetworkException {
  final String url;

  ServerException({required this.url});

  @override
  String get message => "Server error from $url";

  @override
  AppException toAppException() {
    return AppNetworkException.fromNetworkException(this);
  }
}

class HttpResponseException implements NetworkException {
  final int statusCode;
  final ErrorResponse errorResponse;
  final String url;

  HttpResponseException({
    required this.url,
    required this.errorResponse,
    required this.statusCode,
  });
  @override
  String get message =>
      "Http error from $url with $statusCode and error: $errorResponse";

  @override
  AppException toAppException() {
    if (statusCode == 403) {
      return AppUnauthenticatedException();
    } else {
      return AppNetworkException(errorResponse.message);
    }
  }
}
