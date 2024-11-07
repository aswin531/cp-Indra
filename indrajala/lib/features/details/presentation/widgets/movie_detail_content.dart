import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/widgets/trailerpurchasebutton.dart';
import 'package:indrajala/features/details/data/models/moviedetail_model.dart';
import 'package:indrajala/features/details/presentation/widgets/movie_details.dart';
import 'package:indrajala/features/details/presentation/widgets/movie_poster.dart';
import 'package:indrajala/features/details/presentation/widgets/videoplayer.dart';
import 'package:indrajala/features/subscription/presentation/subscription_screen.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetailModel movie;
  final String trailerUrl;

  const MovieDetailContent({super.key, required this.movie, required this.trailerUrl});

  @override
  Widget build(BuildContext context) {
    String fullTrailerUrl = '${ApiConstants.imageBaseUrl}${movie.trailerVideo}';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviePoster(imageUrl: ApiConstants.imageBaseUrl + movie.movieFullImage),
          MovieDetails(movie: movie),
          const SizedBox(height: 20),
          Trailerpurchasebutton(
            color: Colors.blue,
            iconColor: IAppColors.white,
            textStyle: IAppTextStyles.bodyText,
            icon: Icons.play_arrow,
            text: 'Watch Trailer',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(trailerUrl: fullTrailerUrl),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Trailerpurchasebutton(
            iconColor: IAppColors.bgBlack,
            textStyle: IAppTextStyles.bodyTextBlack,
            color: Colors.yellow,
            icon: Icons.workspace_premium,
            text: 'Purchase Premium',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubscriptionPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}