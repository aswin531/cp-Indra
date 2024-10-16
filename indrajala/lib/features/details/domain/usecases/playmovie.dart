import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';

class GetMovieStreamUrlUseCase {
  final MovieDetailRepository repository;

  GetMovieStreamUrlUseCase(this.repository);

  Future<String> execute(String url) async {
    return await repository.getMovieStreamUrl(url);
  }
}