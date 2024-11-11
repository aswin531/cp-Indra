import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/core/widgets/himmer_loading.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_state.dart';
import 'package:indrajala/features/home/presentation/widgets/carousel_slider.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_display_constants.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_section.dart';

// movie_display_widget.dart
class MovieDisplayWidget extends StatelessWidget {
  const MovieDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return switch (state) {
          MovieLoading() => const ShimmerLoading(),
          MovieError() => Center(
              child: Text(
                state.message.contains('No Internet')
                    ? 'No internet connection. Please check your network.'
                    : 'Oops, something went wrong!',
                style: IAppTextStyles.subtitle,
              ),
            ),
          MovieLoaded() => _buildLoadedContent(state),
          _ => const Center(child: Text('No movies found.')),
        };
      },
    );
  }

  Widget _buildLoadedContent(MovieLoaded state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselWidget(movies: state.carouselImages),
          const SizedBox(height: MovieDisplayConstants.sectionSpacing),
          MovieSection(
            movies: state.trendingMovies,
            headerImage: 'assets/images/trending.png',
          ),
          MovieSection(
            movies: state.topFiveMovies,
            headerImage: 'assets/images/topfive.png',
          ),
          MovieSection(
            movies: state.upcomingMovies,
            headerImage: 'assets/images/upcoming.png',
          ),
        ],
      ),
    );
  }
}
