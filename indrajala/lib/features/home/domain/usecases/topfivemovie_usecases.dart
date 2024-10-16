import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';

class GetTopFiveMoviesUseCase {
  final MovieRepository movieRepository;

  GetTopFiveMoviesUseCase(this.movieRepository);

  Future<List<Movie>> call() async {
    return await movieRepository.getTopFiveMovies();
  }
}
