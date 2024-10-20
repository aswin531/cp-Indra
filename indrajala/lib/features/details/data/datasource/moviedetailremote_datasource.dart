import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indrajala/core/constants/api_constants.dart';
import 'package:indrajala/core/constants/http_statuscode.dart';
import 'package:indrajala/core/exceptions/api_exceptions.dart';
import 'package:indrajala/features/details/data/models/moviedetail_model.dart';

class MoviedetailremoteDatasource {
  MoviedetailremoteDatasource();

  Future<MovieDetailModel> getMovieDetail(String url) async {
    final response = await httpClient.get(
      Uri.parse('${ApiConstants.userEndpoint}/movie/$url'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == HttpStatusCodes.ok) {
      final jsonResponse = json.decode(response.body);
      return MovieDetailModel.fromJson(jsonResponse);
    } else {
      throw ApiException(response.statusCode,
          customMessage: 'Failed to load movie details');
    }
  }

  Future<String> getMovieStreamUrl(String url) async {
    final response = await httpClient.get(
        Uri.parse('https://api.indrajala.in/api/user/DeltaFetchMovie/$url'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final movieVideo = data['movieVideo'] ?? '';

      // Construct the complete URL
      final completeUrl =
          'https://api.indrajala.in/public${movieVideo.startsWith('/') ? '' : '/'}$movieVideo';

     // print('Complete Movie URL: $completeUrl');

      if (completeUrl.isEmpty) {
        throw ApiException(response.statusCode,
            customMessage: 'Movie URL is empty');
      }
      return completeUrl;
    } else {
      throw ApiException(response.statusCode,
          customMessage: 'Failed to get movie stream URL');
    }
  }

  Future<String> getTrailerStreamUrl(String trailerUrl) async {
    try {
      final response = await httpClient.get(Uri.parse(trailerUrl));

      if (response.statusCode == HttpStatusCodes.ok) {
        // Verify that the URL is actually a video URL
        if (trailerUrl.contains('.mp4') || trailerUrl.contains('.m3u8')) {
          return trailerUrl;
        } else {
          throw Exception('Invalid video URL format');
        }
      } else {
        throw Exception(
            'Failed to get trailer stream URL: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error fetching trailer URL: $e");
      rethrow;
    }
  }

  Future<bool> checkSubscriptionStatus(String token) async {
    final url = Uri.parse(ApiConstants.checkExpiry);
    final response = await httpClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['isValid'] as bool;
    } else {
      throw Exception('Failed to check subscription status');
    }
  }
}
