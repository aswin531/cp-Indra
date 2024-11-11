import 'package:flutter/material.dart';
import 'package:indrajala/features/details/presentation/widgets/subscriptioncheck.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/presentation/widgets/mobile_movie_card.dart';

class LatestReleasesWidget extends StatelessWidget {
  final List<Movie> movies;
  final String headerImage;

  const LatestReleasesWidget({
    super.key,
    required this.movies,
    required this.headerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    headerImage,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Movies List Section
        SizedBox(
          height: 340,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SubscriptionCheckScreen(movieUrl: movie.url),
                      ),
                    );
                  },
                  child: MobileMovieCard(
                    title: movie.movieName,
                    imageUrl: movie.movieMobileImage,
                    rating: movie.rating,
                    // duration: movie.,
                    genres: movie.category,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
