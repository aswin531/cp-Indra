import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_event.dart';
import 'package:indrajala/features/auth/bloc/visibilitybloc/visibility_state.dart';


class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityState(false)) {
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibilityEvent event, Emitter<PasswordVisibilityState> emit) {
    emit(PasswordVisibilityState(!state.isVisible));
  }
}