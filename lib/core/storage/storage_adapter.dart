import 'dart:convert';

import 'package:mobile_version/core/exceptions/storage_exception.dart';
import 'package:mobile_version/core/storage/storage_session.dart';

abstract class StorageAdapter {
  Future<T> read<T>(Storagekeys key, T Function(dynamic) fromJson);
  Future<void> write(Storagekeys key, dynamic Function() toJson);
  Future<void> delete(Storagekeys key);
}

final class StorageAdapterImpl implements StorageAdapter {
  final StorageSession _session;

  StorageAdapterImpl({required StorageSession session}) : _session = session;

  @override
  Future<T> read<T>(Storagekeys key, T Function(dynamic) fromJson) async {
    final result = await _session.read(key.value);
    if (result != null) {
      final decoded = jsonDecode(result);
      return fromJson(decoded);
    } else {
      throw NullValuesStorageException();
    }
  }

  @override
  Future<void> write(Storagekeys key, Function() toJson) async {
    final encoded = jsonEncode(toJson());
    await _session.write(key.value, encoded);
  }

  @override
  Future<void> delete(Storagekeys key) async {
    await _session.delete(key.value);
  }
}

enum Storagekeys {
  userKey;

  String get value {
    switch (this) {
      case Storagekeys.userKey:
        return 'user_key';
    }
  }
}
