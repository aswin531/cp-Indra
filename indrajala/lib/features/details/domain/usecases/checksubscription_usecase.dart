import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';

class CheckSubscriptionStatusUseCase {
  final MovieDetailRepository repository;

  CheckSubscriptionStatusUseCase(this.repository);

  Future<bool> execute(String token) async {
    return await repository.checkSubscriptionStatus(token);
  }
}