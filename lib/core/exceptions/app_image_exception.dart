abstract class AppImageException implements Exception {
  final String message;

  AppImageException({required this.message});
}

class AppImageErrorException extends AppImageException {
  AppImageErrorException({required super.message});
}
