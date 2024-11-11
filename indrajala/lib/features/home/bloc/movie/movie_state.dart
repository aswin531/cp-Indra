import 'package:indrajala/features/home/data/model/movie_model.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> trendingMovies;
  final List<Movie> topFiveMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> carouselImages;

  MovieLoaded(
      {required this.trendingMovies,
      required this.topFiveMovies,
      required this.upcomingMovies,
      required this.carouselImages});
}

class UpComingMovieLoaded extends MovieState {
  final List<Movie> upcomingMovies;

  UpComingMovieLoaded({
    required this.upcomingMovies,
  });
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);
}
