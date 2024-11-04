
// shimmer_loading.dart
import 'package:flutter/material.dart';
import 'package:indrajala/core/widgets/shimmer_container.dart';
import 'package:indrajala/core/widgets/shimmer_listview.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_display_constants.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerContainer(
            height: MovieDisplayConstants.carouselHeight,
          ),
          const SizedBox(height: MovieDisplayConstants.sectionSpacing),
          _buildShimmerSection(),
          _buildShimmerSection(),
          _buildShimmerSection(),
        ],
      ),
    );
  }

  Widget _buildShimmerSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerContainer(
          height: MovieDisplayConstants.shimmerHeaderHeight,
          width: MovieDisplayConstants.shimmerHeaderWidth,
        ),
        SizedBox(height: 10),
        ShimmerList(),
        SizedBox(height: MovieDisplayConstants.sectionSpacing),
      ],
    );
  }
}