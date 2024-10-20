
import 'package:equatable/equatable.dart';

class MovieDetailModel extends Equatable {
  final String id;
  final String movieName;
  final String rating;
  final String ageLimit;
  final String description;
  final String duration;
  final List<String> starring;
  final List<String> category;
  final String url;
  final String movieFullImage;
  final String movieLogoImage;
  final String movieMobileImage;
  final String smallMovieImage;
  final String trailerVideo;
  final String? movieVideo;
  final int like;
  final int views;
  final int dislike;
  final DateTime createdAt;

  const MovieDetailModel({
    required this.id,
    required this.movieName,
    required this.rating,
    required this.ageLimit,
    required this.description,
    required this.duration,
    required this.starring,
    required this.category,
    required this.url,
    required this.movieFullImage,
    required this.movieLogoImage,
    required this.movieMobileImage,
    required this.smallMovieImage,
    required this.trailerVideo,
    this.movieVideo,
    required this.like,
    required this.views,
    required this.dislike,
    required this.createdAt,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['_id'],
      movieName: json['movieName'],
      rating: json['rating'],
      ageLimit: json['ageLimit'],
      description: json['description'],
      duration: json['duration'],
      starring: List<String>.from(json['starring']),
      category: List<String>.from(json['category']),
      url: json['url'],
      movieFullImage: json['movieFullImage'],
      movieLogoImage: json['movieLogoImage'],
      movieMobileImage: json['movieMobileImage'],
      smallMovieImage: json['smallMovieImage'],
      trailerVideo: json['trailerVideo'],
      movieVideo: json['movieVideo'] ??
          json['trailerVideo'] ??
          '', // Fallback to trailerVideo if movieVideo is not present
      like: json['like'],
      views: json['views'],
      dislike: json['dislike'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        movieName,
        rating,
        ageLimit,
        description,
        duration,
        starring,
        category,
        url,
        movieFullImage,
        movieLogoImage,
        movieMobileImage,
        smallMovieImage,
        trailerVideo,
        movieVideo,
        like,
        views,
        dislike,
        createdAt,
      ];
}
