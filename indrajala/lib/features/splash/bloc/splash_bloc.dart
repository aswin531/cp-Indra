import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/auth/data/datasources/authlocal_datasource.dart';
import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';
import 'package:indrajala/features/splash/bloc/splash_event.dart';
import 'package:indrajala/features/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository authRepository;
  final AuthLocalDatasource _localDatasource = AuthLocalDatasource(); // Initialize the datasource

  SplashBloc(this.authRepository) : super(SplashInitial()) {
    on<StartTimerEvent>(_onStartTimer);
  }

  Future<void> _onStartTimer(StartTimerEvent event, Emitter<SplashState> emit) async {
    try {
      String? token = await _localDatasource.getToken();
      bool isExpired = await _localDatasource.isTokenExpired();

      if (token != null && !isExpired) {
        // Token is valid, navigate to home
        emit(NavigateToHomeState());
      } else {
        // No valid token, navigate to login
        emit(NavigateToLoginState());
      }
    } catch (e) {
      emit(NavigateToLoginState()); // In case of error, fallback to login
    }
  }
}
