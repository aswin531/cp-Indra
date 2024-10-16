import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/domain/repository/movie_repository.dart';

class GetCarouselImagesUseCase {
  final MovieRepository repository;

  GetCarouselImagesUseCase(this.repository);

  Future<List<Movie>>  call() async {
    return await repository.getCarrouselFiveMovies();
  }
}