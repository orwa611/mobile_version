import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/core/exceptions/network_exception.dart';
import 'package:mobile_version/core/network/network_session.dart';
import 'package:mobile_version/models/article_response.dart';
import 'package:mobile_version/models/comment_request.dart';

abstract class CommentService {
  Future<CommentResponse> postComments(CommentRequest request);
}

class CommentServiceImpl implements CommentService {
  final NetworkSession _session;

  CommentServiceImpl({required NetworkSession session}) : _session = session;

  @override
  Future<CommentResponse> postComments(CommentRequest request) async {
    try {
      final result = await _session.post(
        '/article/${request.commenterId}/comments',
        body: request.toJson(),
      );
      return CommentResponse.fromJson(result);
    } on NetworkException catch (e) {
      throw AppNetworkException.fromNetworkException(e);
    }
  }
}
