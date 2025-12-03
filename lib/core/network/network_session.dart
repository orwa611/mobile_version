abstract class NetworkSession {
  Future<dynamic> post(
    String path, {
    Map<String, String> headers,
    Object? body,
  });
  Future<dynamic> put(String path, {Map<String, String> headers, Object? body});
  Future<dynamic> get(String path, {Map<String, String> headers});
  Future<dynamic> delete(String path, {Map<String, String> headers});
}
