// shimmer_container.dart
import 'package:flutter/material.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_display_constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerContainer({
    super.key,
    this.height = MovieDisplayConstants.shimmerBaseHeight,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
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
}