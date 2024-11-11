import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/details/presentation/widgets/subscriptioncheck.dart';
import 'package:indrajala/features/home/bloc/movie/movie_bloc.dart';
import 'package:indrajala/features/home/bloc/movie/movie_state.dart';

class UpcomingMoviesGrid extends StatelessWidget {
  const UpcomingMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IAppColors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: IAppColors.grey,
          ),
        ),
        backgroundColor: IAppColors.transparent,
        title: Text(
          'Upcoming Movies',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: IAppColors.grey,
            fontSize: 18,
          ),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            final upcomingMovies = state.upcomingMovies;
            const fullImageUrl = ApiConstants.imageBaseUrl;

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: upcomingMovies.length,
                itemBuilder: (context, index) {
                  final movie = upcomingMovies[index];
                  return GestureDetector(
                     onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SubscriptionCheckScreen(movieUrl: movie.url),
                      ),
                    );
                  },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: fullImageUrl + movie.movieMobileImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          movie.movieName,
                          style: TextStyle(
                            color: IAppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          movie.category.first,
                          style: TextStyle(
                            color: IAppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No movies found.'));
          }
        },
      ),
    );
  }
}
