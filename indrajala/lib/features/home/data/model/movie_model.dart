class Movie {
  final String id;
  final String movieName;
  final String rating;
  final String description;
  final List<String> category;
  final String url;
  final String movieFullImage;
  final String movieLogoImage;
  final String movieMobileImage;
  final String smallMovieImage;

  Movie({
    required this.id,
    required this.movieName,
    required this.rating,
    required this.description,
    required this.category,
    required this.url,
    required this.movieFullImage,
    required this.movieLogoImage,
    required this.movieMobileImage,
    required this.smallMovieImage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      movieName: json['movieName'],
      rating: json['rating'],
      description: json['description'],
      category: List<String>.from(json['category']),
      url: json['url'],
      movieFullImage: json['movieFullImage'] ?? 'MovieFullImage',
      movieLogoImage: json['movieLogoImage'] ?? 'MovieFullImage',
      movieMobileImage: json['movieMobileImage'] ?? '',
      smallMovieImage: json['smallMovieImage'] ?? 'MovieFullImage',
    );
  }
}
