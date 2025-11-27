import 'package:mobile_version/core/exceptions/network_exception.dart';

abstract class AppException implements Exception {
  final String message;

  AppException({required this.message});
}

class AppNetworkException implements AppException {
  final String? error;

  AppNetworkException(this.error);

  @override
  String get message =>
      (error != null && error!.isNotEmpty) ? error! : 'Error Occured';

  factory AppNetworkException.fromNetworkException(NetworkException e) {
    String? errorMessage;
    switch (e) {
      case HttpResponseException httpResponseException:
        errorMessage = httpResponseException.errorResponse.message;
      default:
        errorMessage = 'Error Occured';
    }
    return AppNetworkException(errorMessage);
  }
}

final class AppUnauthenticatedException extends AppException {
  AppUnauthenticatedException() : super(message: '');

  @override
  String get message => 'you are not Logged in';
}
