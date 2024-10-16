import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';

class GetTopTrendingMoviesUseCase {
  final MovieRepository movieRepository;

  GetTopTrendingMoviesUseCase(this.movieRepository);

  Future<List<Movie>> call() async {
    return await movieRepository.getTopTrendingMovies();
  }
}
