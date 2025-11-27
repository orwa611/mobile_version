import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/services/auth_service.dart';
import 'package:mobile_version/services/auth_storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final AuthStorageService authStorageService;
  AuthBloc({required this.authService, required this.authStorageService})
    : super(AuthStateInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        final result = await authService.login(event.email, event.password);
        await authStorageService.saveUserToken(result);
        emit(AuthStateSucces(token: result.token));
      } on AppException catch (e) {
        emit(AuthStateError(errorMessage: e.message));
      }
    });
  }
}
