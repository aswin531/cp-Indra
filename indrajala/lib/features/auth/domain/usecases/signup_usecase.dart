import 'package:indrajala/features/auth/data/repositories/auth_repository.dart';
import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<AuthResult> call(String name, String email, String password) async {
    return await authRepository.signup(name, email, password);
  }
}
