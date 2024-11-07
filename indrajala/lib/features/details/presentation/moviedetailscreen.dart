import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/widgets/custom_snackbar.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_bloc.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_event.dart';
import 'package:indrajala/features/details/bloc/moviebloc/moviedetail_state.dart';
import 'package:indrajala/features/details/presentation/widgets/movie_detail_content.dart';


class MovieDetailScreen extends StatelessWidget {
  final String movieUrl;
  final String trailerUrl;

  const MovieDetailScreen({super.key, required this.movieUrl, required this.trailerUrl});

  @override
  Widget build(BuildContext context) {
    // Fetch movie details when the screen is built
    context.read<MovieDetailBloc>().add(FetchMovieDetail(url: movieUrl));

    return Scaffold(
      backgroundColor: IAppColors.bgBlack,
      body: SafeArea(
        child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is TrailerError) {
              showCustomSnackbar(context, state.message, IAppColors.red);
            }
          },
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              return MovieDetailContent(movie: state.movie, trailerUrl: trailerUrl);
            } else if (state is MovieDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}





