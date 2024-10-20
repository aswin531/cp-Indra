import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final String placeholderImage;
  final ShapeBorder shapeBorder;

  const ShimmerPlaceholder.rectangular({
    super.key,
    required this.width,
    required this.height,
    required this.placeholderImage,
  })  : shapeBorder = const RoundedRectangleBorder();

  const ShimmerPlaceholder.circular({
    super.key,
    required this.width,
    required this.height,
    required this.placeholderImage,
  })  : shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Placeholder asset image (background)
        Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: shapeBorder,
            image: DecorationImage(
              image: AssetImage(placeholderImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Shimmer effect (overlay)
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: Colors.grey[400],
              shape: shapeBorder,
            ),
          ),
        ),
      ],
    );
  }
}
