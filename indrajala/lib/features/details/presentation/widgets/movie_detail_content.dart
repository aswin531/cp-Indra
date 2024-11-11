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

  const MovieDetailContent(
      {super.key, required this.movie, required this.trailerUrl});

  @override
  Widget build(BuildContext context) {
    String fullTrailerUrl = '${ApiConstants.imageBaseUrl}${movie.trailerVideo}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoviePoster(
                    movieName: movie.movieName,
                    imageUrl: ApiConstants.imageBaseUrl + movie.movieFullImage),
                MovieDetails(movie: movie),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: IAppColors.black,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TrailerPurchaseButton(
                  primaryColor: IAppColors.bgBlack,
                  secondaryColor: IAppColors.bgBlack,
                  isPremium: false,
                  iconColor: IAppColors.white,
                  textStyle: IAppTextStyles.bodyText,
                  icon: Icons.play_arrow,
                  text: 'Watch Trailer',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayerScreen(trailerUrl: fullTrailerUrl),
                      ),
                    );
                  },
                ),
                TrailerPurchaseButton(
                  primaryColor: IAppColors.yellow,
                  secondaryColor: IAppColors.yellow,
                  isPremium: false,
                  iconColor: IAppColors.bgBlack,
                  textStyle: IAppTextStyles.bodyTextBlack,
                  text: 'Play Movie',
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
          ),
        ),
      ],
    );
  }
}
