

import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/details/data/datasource/moviedetailremote_datasource.dart';
import 'package:indrajala/features/details/data/models/movieDetail_model.dart';
import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final MoviedetailremoteDatasource remoteDataSource;

  MovieDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetailModel> getMovieDetail(String url) async {
    try {
      final remoteMovieDetail = await remoteDataSource.getMovieDetail(url);
      return remoteMovieDetail;
    } catch (e) {
      if (e is ApiException) {
        throw ApiException(e.statusCode, customMessage: e.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    }
  }

  @override
  Future<String> getTrailerUrl(String viewIdT) async {
    try {
      final trailerUrl = await remoteDataSource.getTrailerStreamUrl(viewIdT);
      return trailerUrl;
    } catch (e) {
      if (e is ApiException) {
        throw ApiException(e.statusCode, customMessage: e.message);
      } else {
        throw Exception('Unknown error occurred');
      }
    }
  }

   @override
  Future<bool> checkSubscriptionStatus(String token) async {
    return await remoteDataSource.checkSubscriptionStatus(token);
  }

   @override
  Future<String> getMovieStreamUrl(String url) async {
    return await remoteDataSource.getMovieStreamUrl(url);
  }
}