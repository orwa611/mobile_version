import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/register_bloc/register_event.dart';
import 'package:mobile_version/blocs/register_bloc/register_state.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/services/register_service.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterService _service;
  RegisterBloc(RegisterService service)
    : _service = service,
      super(RegistrationStateInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        emit(RegistrationStateLoading());
        final _ = await _service.register(event.request);
        emit(RegistrationStateSuccess());
      } on AppException catch (e) {
        emit(RegistrationStateError(errorMessage: e.message));
      }
    });
  }
}
