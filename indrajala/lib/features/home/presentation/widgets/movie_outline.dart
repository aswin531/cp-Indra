import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/details/presentation/widgets/subscriptioncheck.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_card.dart';

class LatestReleasesWidget extends StatelessWidget {
  final List<Movie> movies;
  final String headerImage;

  const LatestReleasesWidget({
    super.key,
    required this.movies,
    required this.headerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: IAppColors.transparent,
              child: Image.asset(
                headerImage,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: 310,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    debugPrint(movie.url);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SubscriptionCheckScreen(movieUrl: movie.url),
                      ),
                    );//
                  },
                  child: MovieCard(
                    title: movie.movieName,
                    imageUrl: movie.movieMobileImage,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}








//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       context
//                           .read<MovieDetailBloc>()
//                           .add(FetchMovieDetail(url: movie.url));
// // return WatchMovieScreen(movieUrl: movie.url,);
//                       return MovieDetailScreen(movieUrl: movie.url);
//                     }
//                     ),

//                     );