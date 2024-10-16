import 'package:indrajala/features/auth/data/repositories/auth_repository.dart';
import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<AuthResult> call(String email, String password) async {
    return await authRepository.login(email, password);
    
  }
}
