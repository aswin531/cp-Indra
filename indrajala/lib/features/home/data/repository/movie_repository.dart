import 'package:indrajala/features/home/data/datasource/movieremote_datasource.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getTopTrendingMovies() {
    return remoteDataSource.fetchTopTrendingMovies();
  }

  @override
  Future<List<Movie>> getUpcomingMovies() {
    return remoteDataSource.fetchUpcomingMovies();
  }

  @override
  Future<List<Movie>> getTopFiveMovies() {
    return remoteDataSource.fetchTopFiveMovies();
  }
  
  @override
  Future<List<Movie>> getCarrouselFiveMovies() {
    return remoteDataSource.fetchCarouselFiveMovies();
  }
}
