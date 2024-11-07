import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_theme.dart';

class MoviePoster extends StatelessWidget {
  final String imageUrl;

  const MoviePoster({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: double.infinity,
      height: 300,
      fit: BoxFit.cover,
      placeholder: (context, url) => const ShimmerPlaceholder.rectangular(
        width: double.infinity,
        height: 300,
        placeholderImage: 'assets/images/playstore.png',
      ),
    );
  }
}