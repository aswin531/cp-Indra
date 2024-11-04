// shimmer_list.dart
import 'package:flutter/material.dart';
import 'package:indrajala/features/home/presentation/widgets/movie_display_constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  final double height;
  final int itemCount;
  final double itemWidth;

  const ShimmerList({
    super.key,
    this.height = MovieDisplayConstants.shimmerListHeight,
    this.itemCount = MovieDisplayConstants.shimmerItemCount,
    this.itemWidth = MovieDisplayConstants.shimmerItemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) => Padding(
            padding: MovieDisplayConstants.shimmerItemPadding,
            child: Container(
              width: itemWidth,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}