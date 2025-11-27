part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentStateInitial implements CommentState {}

class CommentStateSuccess implements CommentState {
  final CommentModel comment;

  CommentStateSuccess({required this.comment});
}

class CommentStateLoading implements CommentState {}

class CommentStateError implements CommentState {
  final String errorMessage;

  CommentStateError({required this.errorMessage});
}
