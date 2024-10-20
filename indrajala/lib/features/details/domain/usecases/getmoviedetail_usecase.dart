import 'package:indrajala/features/details/data/models/moviedetail_model.dart';
import 'package:indrajala/features/details/domain/repository/moviedetail_repo.dart';

class GetMovieDetailUsecase {
  final MovieDetailRepository repository;

  GetMovieDetailUsecase(this.repository);

  Future<MovieDetailModel> call(String url) async {
    return await repository.getMovieDetail(url);
  }
}