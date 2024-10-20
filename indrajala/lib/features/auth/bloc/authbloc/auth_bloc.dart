import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_event.dart';
import 'package:indrajala/features/auth/bloc/authbloc/auth_state.dart';
import 'package:indrajala/features/auth/domain/usecases/gettoken_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/login_usecases.dart';
import 'package:indrajala/features/auth/domain/usecases/logout_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/signup_usecase.dart';
import 'package:indrajala/features/auth/domain/usecases/tokenexpiry_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final CheckTokenExpirationUseCase checkTokenExpirationUseCase;
  final LogoutUseCase logoutUseCase;
  final GetTokenUseCase getTokenUseCase;

  AuthBloc(
      this.loginUseCase,
      this.signUpUseCase,
      this.checkTokenExpirationUseCase,
      this.getTokenUseCase,
      this.logoutUseCase)
      : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<CheckTokenExpirationEvent>(_onCheckTokenExpiration);
    on<GetTokenEvent>(_onGetTokenEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<InitializeAuthEvent>(_onInitializeAuthEvent);
  }

  Future<void> _onInitializeAuthEvent(
      InitializeAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await getTokenUseCase();
      if (token != null) {
        // Check if the token is expired
        final isExpired = await checkTokenExpirationUseCase();
        if (isExpired) {
          emit(AuthTokenExpired());
        } else {
          emit(Authenticated());
        }
      } else {
        emit(LoggedOut());
      }
    } catch (e) {
      emit(const AuthError("An unexpected error occurred"));
    }
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await loginUseCase(event.email, event.password);
      if (result.success) {
     //   await prefs.setString('user_token', result.);
        emit(Authenticated());
      } else {
        emit(const AuthError("Invalid credentials"));
      }
    } catch (e) {
      if (e is ApiException) {
        emit(AuthError(e.message));
      } else {
        emit(const AuthError("An unexpected error occurred"));
      }
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signUpUseCase(event.name, event.email, event.password);
      //  await prefs.setString('user_token', result.token);
      emit(Authenticated());
    } catch (e) {
      if (e is ApiException) {
        emit(AuthError(e.message));
      } else {
        emit(const AuthError("An unexpected error occurred"));
      }
    }
  }

  Future<void> _onCheckTokenExpiration(
      CheckTokenExpirationEvent event, Emitter<AuthState> emit) async {
    final isExpired = await checkTokenExpirationUseCase();
    if (isExpired) {
      emit(AuthTokenExpired());
    } else {
      emit(Authenticated());
    }
  }

  Future<void> _onGetTokenEvent(
      GetTokenEvent event, Emitter<AuthState> emit) async {
    final token = await getTokenUseCase();
    if (token != null) {
      emit(TokenRetrieved(token));
      //debugPrint('TOken In AUTHBLOC : $token');
    } else {
      emit(const AuthError("Token retrieval failed"));
    }
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
   // print("Logging out...");

    await logoutUseCase();
    emit(LoggedOut());
  }
}
