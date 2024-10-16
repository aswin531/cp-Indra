import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = ApiConstants.imageBaseUrl + imageUrl;
    return SizedBox(
      width: 220,
      height: 220,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: fullImageUrl,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) {
                  return const Icon(Icons.error);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
