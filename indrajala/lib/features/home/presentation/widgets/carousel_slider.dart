import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/core/theme/app_textstyles.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_event.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_state.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';

class CarouselWidget extends StatelessWidget {
  final List<Movie> movies;

  const CarouselWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            viewportFraction: 1,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            onPageChanged: (index, reason) {
              context.read<IndicatorBloc>().add(UpdateIndicator(index));
            },
          ),
          items: movies.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Curves the whole carousel content
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: ApiConstants.imageBaseUrl + movie.smallMovieImage,
                          placeholder: (context, url) => Image.asset(
                              'assets/images/movieph.jpg',
                              fit: BoxFit.cover),
                          errorWidget: (context, url, error) {
                            debugPrint('Error loading image: $error for URL: ${movie.smallMovieImage}');
                            return const Icon(Icons.error);
                          },
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity, // Ensures the image fills the space
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating ${movie.rating}',
                                style: IAppTextStyles.subtitle.copyWith(
                                  color: IAppColors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                movie.category.first,
                                style: IAppTextStyles.bodyText.copyWith(
                                  color: IAppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                movie.description,
                                style: IAppTextStyles.localtext.copyWith(
                                  color: IAppColors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 3, // Limiting the number of lines for better display
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10), // Add some spacing
        BlocBuilder<IndicatorBloc, IndicatorState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: movies.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(
                      state.currentIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
