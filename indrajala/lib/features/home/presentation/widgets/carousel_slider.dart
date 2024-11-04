import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_event.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';
import 'package:indrajala/features/home/presentation/widgets/carousel_indicator.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_carousel_item.dart';


class CarouselWidget extends StatelessWidget {
  final List<Movie> movies;

  const CarouselWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: size.height * 0.6,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              context.read<IndicatorBloc>().add(UpdateIndicator(index));
            },
          ),
          items: movies.map((movie) => MovieCarouselItem(movie: movie)).toList(),
        ),
        const SizedBox(height: 16),
        CarouselIndicator(movies: movies),
      ],
    );
  }
}



