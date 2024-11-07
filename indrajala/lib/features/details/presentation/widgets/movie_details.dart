
import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/details/data/models/moviedetail_model.dart';
import 'package:indrajala/features/details/presentation/widgets/detail_text.dart';

class MovieDetails extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(movie.movieName, style: IAppTextStyles.heading1),
          ),
          const SizedBox(height: 8),
          DetailText(label: 'Rating', value: movie.rating),
          DetailText(label: 'Age', value: '${movie.ageLimit}+'),
          DetailText(label: 'Duration', value: movie.duration),
          const SizedBox(height: 8),
          Text(movie.description, style: IAppTextStyles.descriptionText),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.center,
            child: DetailText(label: 'Starring', value: movie.starring.first),
          ),
        ],
      ),
    );
  }
}
