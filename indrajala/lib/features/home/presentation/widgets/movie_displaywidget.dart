import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_state.dart';
import 'package:indrajala/features/home/presentation/widgets/carousel_slider.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_outline.dart';
import 'package:shimmer/shimmer.dart';

class MovieDisplayWidget extends StatelessWidget {
  const MovieDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return _buildShimmerEffect();
        } else if (state is MovieError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is MovieLoaded) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselWidget(
                  movies: state.carouselImages,
                ),
                const SizedBox(
                  height: 15,
                ),
                LatestReleasesWidget(
                  movies: state.trendingMovies,
                  headerImage: 'assets/images/trending.png',
                ),
                const SizedBox(
                  height: 15,
                ),
                LatestReleasesWidget(
                  movies: state.topFiveMovies,
                  headerImage: 'assets/images/topfive.png',
                ),
                const SizedBox(
                  height: 15,
                ),
                LatestReleasesWidget(
                  movies: state.upcomingMovies,
                  headerImage: 'assets/images/upcoming.png',
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('No movies found.'));
      },
    );
  }

  Widget _buildShimmerEffect() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(height: 200),
          const SizedBox(height: 15),
          _buildShimmerBox(height: 25, width: 150),
          const SizedBox(height: 10),
          _buildShimmerList(),
          const SizedBox(height: 15),
          _buildShimmerBox(height: 25, width: 150),
          const SizedBox(height: 10),
          _buildShimmerList(),
          const SizedBox(height: 15),
          _buildShimmerBox(height: 25, width: 150),
          const SizedBox(height: 10),
          _buildShimmerList(),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(
      {double height = 100, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: 100,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
