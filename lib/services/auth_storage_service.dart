import 'package:mobile_version/core/network/authenticated_dio_network_session.dart';
import 'package:mobile_version/core/storage/storage_adapter.dart';
import 'package:mobile_version/models/login_response.dart';

class AuthStorageService implements GetTokenManager {
  final StorageAdapter _storage;

  AuthStorageService({required StorageAdapter storage}) : _storage = storage;

  Future<void> saveUserToken(LoginResponse loginResponse) async {
    await _storage.write(Storagekeys.userKey, loginResponse.toJson);
  }

  Future<void> deleteToken() async {
    await _storage.delete(Storagekeys.userKey);
  }

  Future<bool> isTokenSaved() async {
    try {
      await _storage.read<LoginResponse>(Storagekeys.userKey, (value) {
        return LoginResponse.fromJson(value);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final result = await _storage.read<LoginResponse>(Storagekeys.userKey, (
        value,
      ) {
        return LoginResponse.fromJson(value);
      });
      return result.token;
    } catch (e) {
      return '';
    }
  }
}
