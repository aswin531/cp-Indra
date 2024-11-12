import 'package:indrajala/features/auth/domain/repository/auth_repository.dart';

class GetTokenUseCase {
  final AuthRepository authRepository;

  GetTokenUseCase(this.authRepository);

  Future<String?> call() async {
  //  debugPrint('Retrieved token from secure storage:');
    return await authRepository.getToken();
  }
}
