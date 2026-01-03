abstract class AuthorEvent {}

class GetAuthorEvent extends AuthorEvent {
  final String id;

  GetAuthorEvent({required this.id});
}
