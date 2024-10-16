import 'package:indrajala/features/auth/data/repositories/auth_repository.dart';

abstract class AuthRepository {
  Future<AuthResult> login(String email, String password);
  Future<AuthResult> signup(String name, String email, String password);
  Future<String?> getToken();
  Future<bool> isTokenExpired();
  Future<void> logout();
}
