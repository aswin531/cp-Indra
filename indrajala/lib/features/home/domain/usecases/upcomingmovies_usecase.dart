import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';

class GetUpcomingMoviesUseCase {
  final MovieRepository movieRepository;

  GetUpcomingMoviesUseCase(this.movieRepository);

  Future<List<Movie>> call() async {
    return await movieRepository.getUpcomingMovies();
  }
}
