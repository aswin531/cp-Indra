import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:indrajala/features/details/data/models/moviedetail_model.dart';

class MovieDetails extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickInfo(),
          const SizedBox(height: 24),
          _buildDescription(),
          const SizedBox(height: 24),
          _buildCast(),
        ],
      ),
    );
  }

  Widget _buildQuickInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IAppColors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem(
            title: movie.rating,
            subtitle: 'Rating',
            icon: Icons.star_rounded,
          ),
          _buildDivider(),
          _buildInfoItem(
            title: '${movie.ageLimit}+',
            subtitle: 'Age',
            icon: Icons.person_outline,
          ),
          _buildDivider(),
          _buildInfoItem(
            title: movie.duration,
            subtitle: 'Duration',
            icon: Icons.access_time_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: IAppColors.white.withOpacity(0.3),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: IAppColors.white,
          size: 28,
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            color: IAppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: IAppColors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Story',
          style: TextStyle(
            color: IAppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          movie.description,
          style: TextStyle(
            color: IAppColors.white.withOpacity(0.9),
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cast',
          style: TextStyle(
            color: IAppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movie.starring.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: IAppColors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  movie.starring[index],
                  style: TextStyle(
                    color: IAppColors.white,
                    fontSize: 16,
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
