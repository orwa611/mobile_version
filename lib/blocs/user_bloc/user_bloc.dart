import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/services/auth_storage_service.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthStorageService _service;
  UserBloc({required AuthStorageService service})
    : _service = service,
      super(UserStateInitial()) {
    on<UserLoggedInEvent>((event, emit) async {
      final result = await _service.isTokenSaved();
      if (result) {
        emit(UserStateLoggedIn());
      } else {
        emit(UserStateLoggedOut());
      }
    });
    on<UserLoggedOutEvent>((event, emit) async {
      await _service.deleteToken();
      emit(UserStateLoggedOut());
    });
  }
}
