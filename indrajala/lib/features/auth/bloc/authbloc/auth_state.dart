import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}



class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthTokenExpired extends AuthState {}
class LoggedOut extends AuthState {}

// State for token retrieval success
class TokenRetrieved extends AuthState {
  final String token;

  const TokenRetrieved(this.token);

  @override
  List<Object?> get props => [token];
}