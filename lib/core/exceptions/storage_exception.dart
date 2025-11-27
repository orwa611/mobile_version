abstract class StorageException implements Exception {
  final String message;

  StorageException({required this.message});
}

final class NullValuesStorageException implements StorageException {
  @override
  // TODO: implement message
  String get message => 'Value is null in storage';
}
