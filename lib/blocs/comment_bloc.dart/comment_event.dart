part of 'comment_bloc.dart';

abstract class CommentEvent {}

class AddToDbCommentEvent implements CommentEvent {
  final String id;
  final String comment;

  AddToDbCommentEvent({required this.id, required this.comment});
}
