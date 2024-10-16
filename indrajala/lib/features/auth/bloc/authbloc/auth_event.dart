import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAuthEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}


class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent(this.name,this.email, this.password);
  @override
  List<Object?> get props => [name,email, password];
}

class GetTokenEvent extends AuthEvent {}
class CheckTokenExpirationEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}
