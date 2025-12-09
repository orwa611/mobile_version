import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_event.dart';
import 'package:mobile_version/blocs/change_password_bloc/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitialState());
}
