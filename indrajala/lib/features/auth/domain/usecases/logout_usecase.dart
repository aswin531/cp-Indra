import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
}
