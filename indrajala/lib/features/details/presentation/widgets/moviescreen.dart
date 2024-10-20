import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/widgets/trailerpurchasebutton.dart';
import 'package:indrajala/features/details/presentation/widgets/videoplayer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_event.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_state.dart';

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;
            // //  print('MOVIEEE FROM QATCHMOVIE SCREEN " $movie');
            //   final _movieStreamUrl = ApiConstants.imageBaseUrl +
            //       movie.movieVideo!.replaceFirst('//', '/');
            //   //print('MOVIEEE FROM QATCHMOVIE SCREEN " $_movieStreamUrl');

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      ApiConstants.imageBaseUrl + movie.movieFullImage,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              movie.movieName,
                              style: IAppTextStyles.heading1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Rating: ${movie.rating}',
                            style: IAppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Age: ${movie.ageLimit}+',
                            style: IAppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Duration: ${movie.duration}',
                            style: IAppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.description,
                            style: IAppTextStyles.descriptionText,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Starring: ${movie.starring.first}',
                              style: IAppTextStyles.subtitle,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Trailerpurchasebutton(
                            color: Colors.green,
                            iconColor: IAppColors.white,
                            textStyle: IAppTextStyles.bodyText,
                            icon: Icons.play_arrow,
                            text: 'Watch Movie',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(
                                    trailerUrl:
                                        videoUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
      // print('URL check status code: ${response.statusCode}');
      // print('URL check content type: ${response.headers['content-type']}');
      return response.statusCode == 200 &&
          (response.headers['content-type']?.contains('video') ?? false);
    } catch (e) {
//      print('Error checking URL: $e');
      return false;
    }
  }
}
