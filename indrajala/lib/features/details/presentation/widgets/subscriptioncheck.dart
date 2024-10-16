import 'package:flutter/material.dart';
import 'package:indrajala/features/auth/data/datasources/authlocal_datasource.dart';
import 'package:indrajala/features/details/data/datasource/moviedetailremote_datasource.dart';
import 'package:indrajala/features/details/presentation/moviedetailscreen.dart';
import 'package:indrajala/features/details/presentation/widgets/moviescreen.dart';

class SubscriptionCheckScreen extends StatefulWidget {
  final String movieUrl;

  const SubscriptionCheckScreen({super.key, required this.movieUrl});

  @override
  _SubscriptionCheckScreenState createState() =>
      _SubscriptionCheckScreenState();
}

class _SubscriptionCheckScreenState extends State<SubscriptionCheckScreen> {
  final MoviedetailremoteDatasource _movieDataSource =
      MoviedetailremoteDatasource();
  final AuthLocalDatasource _authLocalDatasource = AuthLocalDatasource();

  @override
  void initState() {
    super.initState();
    _checkSubscriptionAndNavigate();
  }

  Future<void> _checkSubscriptionAndNavigate() async {
    try {
      final token = await _authLocalDatasource.getToken();
      print('Token: $token'); // Log the token

      if (token == null) {
        print('No token found, navigating to MovieDetailScreen');
        // _navigateToMovieDetailScreen();
        return;
      }

      final isSubscribed =
          await _movieDataSource.checkSubscriptionStatus(token);
      print('Subscription status: $isSubscribed');

      String videoUrl;
      if (isSubscribed) {
        print(
            'User is subscribed, fetching full movie URL ===== ${widget.movieUrl}');
        videoUrl = await _movieDataSource.getMovieStreamUrl(widget.movieUrl);
        print('/*/*/*/*/*/*/**/**/*/*/ ===== $videoUrl}');
      } else {
        print('User is not subscribed, fetching trailer URL');
        videoUrl = await _movieDataSource.getTrailerStreamUrl(widget.movieUrl);
      }

      if (isSubscribed) {
        print('videoooo url frommm SuBSCRIOTIONCHECK : $videoUrl');
        _navigateToWatchMovieScreen(videoUrl);
      } else {
        _navigateToMovieDetailScreen(videoUrl);
      }
    } catch (e) {
      print('Error checking subscription or fetching video URL: $e');
      _navigateToMovieDetailScreen(null);
    }
  }

  void _navigateToWatchMovieScreen(String videoUrl) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            WatchMovieScreen(movieUrl: widget.movieUrl, videoUrl: videoUrl),
      ),
    );
  }

  void _navigateToMovieDetailScreen(String? trailerUrl) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(
          movieUrl: widget.movieUrl,
          trailerUrl: trailerUrl ??
              '', // Provide a default empty string or handle null case
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
