import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';

class PlayTrailerUsecase {
  final MovieDetailRepository repository;

  PlayTrailerUsecase(this.repository);

  Future<String> call(String viewIdT) async {
    return await repository.getTrailerUrl(viewIdT);
  }
}
