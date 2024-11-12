import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/helper/connectivity_helper.dart';
import 'package:indrajala/features/home/bloc/movie/movie_event.dart';
import 'package:indrajala/features/home/bloc/movie/movie_state.dart';
import 'package:indrajala/features/home/domain/usecases/carousel_usecases.dart';
import 'package:indrajala/features/home/domain/usecases/topfivemovie_usecases.dart';
import 'package:indrajala/features/home/domain/usecases/toptrendingmovies.dart.dart';
import 'package:indrajala/features/home/domain/usecases/upcomingmovies_usecase.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopTrendingMoviesUseCase getTopTrendingMoviesUseCase;
  final GetUpcomingMoviesUseCase getUpcomingMoviesUseCase;
  final GetTopFiveMoviesUseCase getTopFiveMoviesUseCase;
  final GetCarouselImagesUseCase getCarouselImagesUseCase;

  MovieBloc(
    this.getTopTrendingMoviesUseCase,
    this.getTopFiveMoviesUseCase,
    this.getUpcomingMoviesUseCase,
    this.getCarouselImagesUseCase,
  ) : super(MovieInitial()) {
    on<FetchAllMovies>(_onFetchAllMovies);
    on<FetchUpcomingMovies>(_onFetchUpcomingMovies);
  }

  Future<void> _onFetchAllMovies(
    FetchAllMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    try {
      //debugPrint('Fetching movies...');

      final trendingMoviesFuture = getTopTrendingMoviesUseCase();
      final topFiveMoviesFuture = getTopFiveMoviesUseCase();
      final upcomingMoviesFuture = getUpcomingMoviesUseCase();
      final carouselImagesFuture = getCarouselImagesUseCase();
      //debugPrint('Started all movie fetch requests...');

      final results = await Future.wait([
        trendingMoviesFuture,
        topFiveMoviesFuture,
        upcomingMoviesFuture,
        carouselImagesFuture,
      ]);

      emit(MovieLoaded(
        trendingMovies: results[0],
        topFiveMovies: results[1],
        upcomingMovies: results[2],
        carouselImages: results[3],
      ));
      //debugPrint('Movies loaded successfully.');
    } catch (e, stacktrace) {
      //debugPrint('Error occurred while fetching movies: $e');
      //debugPrint('Stacktrace: $stacktrace');
      if (!await checkInternetConnection()) {
        emit(MovieError('No Internet Connection'));
      } else {
        emit(MovieError('An unexpected error occurred.'));
      }
    }
  }

  Future<void> _onFetchUpcomingMovies(
      FetchUpcomingMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    try {
      final upcomigMovies = await getUpcomingMoviesUseCase();
      emit(UpComingMovieLoaded(upcomingMovies: upcomigMovies));
      //debugPrint(
          ///'Upcoming movies loaded successfully.${upcomigMovies.toString()}');
    } catch (e, stacktrace) {
      //debugPrint('Error occurred while fetching upcoming movies: $e');
      //debugPrint('Stacktrace: $stacktrace');
      if (!await checkInternetConnection()) {
        emit(MovieError('No Internet Connection'));
      } else {
        emit(MovieError('An unexpected error occurred.'));
      }
    }
  }
}
