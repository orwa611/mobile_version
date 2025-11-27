import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/models/comment_model.dart';
import 'package:mobile_version/models/comment_request.dart';
import 'package:mobile_version/services/comment_service.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentService _service;

  CommentBloc({required CommentService service})
    : _service = service,
      super(CommentStateInitial()) {
    on<AddToDbCommentEvent>((event, emit) async {
      emit(CommentStateLoading());
      try {
        final result = await _service.postComments(
          CommentRequest(content: event.comment, commenterId: event.id),
        );
        emit(CommentStateSuccess(comment: result.toModel()));
      } on AppException catch (e) {
        emit(CommentStateError(errorMessage: e.message));
      }
    });
  }
}
