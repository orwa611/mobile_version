import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class StorageSession {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

final class SecureStorageSession implements StorageSession {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageSession({required this.flutterSecureStorage});

  @override
  Future<String?> read(String key) async {
    return await flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await flutterSecureStorage.delete(key: key);
  }
}
