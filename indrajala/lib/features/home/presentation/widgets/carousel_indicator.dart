import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_bloc.dart';
import 'package:indrajala/features/home/bloc/indicator/indicator_state.dart';
import 'package:indrajala/features/home/data/model/movie_model.dart';

class CarouselIndicator extends StatelessWidget {
  final List<Movie> movies;

  const CarouselIndicator({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndicatorBloc, IndicatorState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: movies.asMap().entries.map((entry) {
            final isActive = state.currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 24.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).primaryColor.withOpacity(isActive ? 0.9 : 0.4),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}