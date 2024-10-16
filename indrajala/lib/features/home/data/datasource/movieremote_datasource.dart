import 'dart:convert';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/constants/http_statuscode.dart';
import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';

class MovieRemoteDataSource {
  MovieRemoteDataSource();

  Future<List<Movie>> fetchMovies(String moviesendpoint) async {
    try {
      final response = await httpClient.get(Uri.parse(moviesendpoint));

      if (response.statusCode == HttpStatusCodes.ok) {
        List jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());

        return jsonResponse.map((data) => Movie.fromJson(data)).toList();
      } else {
        throw ApiException(response.statusCode,
            customMessage: 'Failed to load movies. Status code: ');
      }
    } catch (e) {

      throw Exception('An error occurred while fetching the movies: $e');
    }
  }

  Future<List<Movie>> fetchTopTrendingMovies() async {
    return await fetchMovies(ApiConstants.topTrendingMovies);
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    return await fetchMovies(ApiConstants.upComingMovies);
  }

  Future<List<Movie>> fetchTopFiveMovies() async {
    return await fetchMovies(ApiConstants.topFiveMovies);
  }

  Future<List<Movie>> fetchCarouselFiveMovies() async {
    return await fetchMovies(ApiConstants.carouselFiveMovies);
  }
}
