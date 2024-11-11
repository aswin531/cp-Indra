import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/widgets/custom_snackbar.dart';
import 'package:indrajala/core/widgets/trailerpurchasebutton.dart';
import 'package:indrajala/features/details/presentation/widgets/movie_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_event.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_state.dart';
import 'package:indrajala/features/details/presentation/widgets/movie_poster.dart';
import 'package:indrajala/features/details/presentation/widgets/videoplayer.dart';

class WatchMovieScreen extends StatelessWidget {
  final String movieUrl;
  final String videoUrl;

  const WatchMovieScreen(
      {super.key, required this.movieUrl, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    context.read<MovieDetailBloc>().add(FetchMovieDetail(url: movieUrl));

    return Scaffold(
      backgroundColor: IAppColors.bgBlack,
      body: SafeArea(
        child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is MovieDetailError) {
              showCustomSnackbar(context, state.message, IAppColors.red);
            }
          },
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;
              // String fullTrailerUrl =
              //     '${ApiConstants.imageBaseUrl}${movie.trailerVideo}';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoviePoster(
                        movieName: movie.movieName,
                        imageUrl:
                            ApiConstants.imageBaseUrl + movie.movieFullImage),
                    MovieDetails(movie: movie),
                    const SizedBox(height: 20),
                    TrailerPurchaseButton(
                        primaryColor: IAppColors.yellow,
                        secondaryColor: IAppColors.yellow,
                        text: 'Watch Movie',
                        textStyle: IAppTextStyles.bodyTextBlack,
                        iconColor: IAppColors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayerScreen(trailerUrl: videoUrl),
                            ),
                          );
                        })
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<bool> isVideoUrlValid(String url) async {
    try {
      final response = await httpClient.head(Uri.parse(url));
      return response.statusCode == 200 &&
          (response.headers['content-type']?.contains('video') ?? false);
    } catch (e) {
      return false;
    }
  }
}
