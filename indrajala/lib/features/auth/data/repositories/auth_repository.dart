import 'package:indrajala/features/auth/data/datasources/authlocal_datasource.dart';
import 'package:indrajala/features/auth/data/datasources/authremote_datasource.dart';
import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<AuthResult> login(String email, String password) async {
    try {
      final authResponse = await remoteDatasource.login(email, password);
      await localDatasource.storeToken(authResponse.token);
      if (authResponse.expiryDate != null) {
        await localDatasource.storeExpiryDate(authResponse.expiryDate!);
      }
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, errorMessage: e.toString());
    }
  }

 @override
  Future<AuthResult> signup(String name, String email, String password) async {
    try {
      final authResponse = await remoteDatasource.signup(name, email, password);
      await localDatasource.storeToken(authResponse.token);
      if (authResponse.expiryDate != null) {
        await localDatasource.storeExpiryDate(authResponse.expiryDate!);
      }
      return AuthResult(success: true);
    } catch (e) {
      return AuthResult(success: false, errorMessage: e.toString());
    }
  }

  @override
  Future<String?> getToken() async {
    return await localDatasource.getToken();
  }

  @override
  Future<bool> isTokenExpired() async {
    return await localDatasource.isTokenExpired();
  }

  @override
  Future<void> logout() async {
    await localDatasource.clearToken();
  }
}

class AuthResult {
  final bool success;
  final String? errorMessage;

  AuthResult({required this.success, this.errorMessage});
}