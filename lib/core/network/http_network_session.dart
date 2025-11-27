import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version/core/constants/network_constants.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/error_response.dart';

class HttpNetworkSession implements NetworkSession {
  final String baseUrl = NetworkConstants.baseUrl;

  @override
  Future<dynamic> post(
    String path, {
    Map<String, String> headers = const {"Content-Type": "application/json"},
    Object? body,
  }) async {
    final url = Uri.parse(baseUrl + path);
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      final decoded = jsonDecode(response.body);
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return decoded;
      } else {
        throw HttpResponseException(
          url: url.toString(),
          statusCode: response.statusCode,
          errorResponse: ErrorResponse.fromJson(decoded),
        );
      }
    } on NetworkException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(url: url.toString());
    }
  }

  @override
  Future get(
    String path, {
    Map<String, String> headers = const {"Content-Type": "application/json"},
  }) async {
    final url = Uri.parse(baseUrl + path);
    try {
      final response = await http.get(url, headers: headers);
      final decoded = jsonDecode(response.body);
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return decoded;
      } else {
        throw HttpResponseException(
          url: url.toString(),
          statusCode: response.statusCode,
          errorResponse: ErrorResponse.fromJson(decoded),
        );
      }
    } on NetworkException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(url: url.toString());
    }
  }

  @override
  Future delete(
    String path, {
    Map<String, String> headers = const {"Content-Type": "application/json"},
  }) async {
    final url = Uri.parse(baseUrl + path);
    try {
      final response = await http.delete(url, headers: headers);
      final decoded = jsonDecode(response.body);
      if (NetworkConstants.statusCodes.contains(response.statusCode)) {
        return decoded;
      } else {
        throw HttpResponseException(
          url: url.toString(),
          statusCode: response.statusCode,
          errorResponse: ErrorResponse.fromJson(decoded),
        );
      }
    } on NetworkException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(url: url.toString());
    }
  }
}
