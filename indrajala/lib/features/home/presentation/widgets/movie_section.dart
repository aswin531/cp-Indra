// movie_section.dart
import 'package:flutter/material.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_display_constants.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_outline.dart';

class MovieSection extends StatelessWidget {
  final List<Movie> movies;
  final String headerImage;

  const MovieSection({
    super.key,
    required this.movies,
    required this.headerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LatestReleasesWidget(
          movies: movies,
          headerImage: headerImage,
        ),
        const SizedBox(height: MovieDisplayConstants.sectionSpacing),
      ],
    );
  }
}