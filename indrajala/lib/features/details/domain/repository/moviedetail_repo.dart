import 'package:indrajala/features/details/data/models/moviedetail_model.dart';

abstract class MovieDetailRepository {
  Future<MovieDetailModel> getMovieDetail(String url);
  Future<String> getTrailerUrl(String viewIdT);
  Future<bool> checkSubscriptionStatus(String token);
  Future<String> getMovieStreamUrl(String url);
}
