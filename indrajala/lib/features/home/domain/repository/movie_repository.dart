import 'package:indrajala/features/home/data/model/movie_model.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTopTrendingMovies();
  Future<List<Movie>> getUpcomingMovies();
  Future<List<Movie>> getTopFiveMovies();
  Future<List<Movie>> getCarrouselFiveMovies();
}
