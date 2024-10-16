import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class CheckTokenExpirationUseCase {
  final AuthRepository authRepository;

  CheckTokenExpirationUseCase(this.authRepository);

  Future<bool> call() async {
    return await authRepository.isTokenExpired();
  }
}
