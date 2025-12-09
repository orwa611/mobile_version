import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_event.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_state.dart';
import 'package:mobile_version/core/exceptions/app_exception.dart';
import 'package:mobile_version/services/account_service.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AccountService _service;
  ChangePasswordBloc({required AccountService service})
    : _service = service,
      super(ChangePasswordInitialState()) {
    on<UpdatePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoadingState());
      try {
        await _service.updatePassword(event.request);
        emit(ChangePasswordSuccessState());
      } on AppException catch (e) {
        emit(ChangePasswordErrorState(errorMessage: e.message));
      }
    });
  }
}
