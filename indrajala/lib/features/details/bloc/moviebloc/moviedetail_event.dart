import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final String url;

  FetchMovieDetail({required this.url});

  @override
  List<Object> get props => [url];
}

class PlayMovieTrailer extends MovieDetailEvent {
  final String url;

  PlayMovieTrailer({required this.url});

  @override
  List<Object> get props => [url];
}

class CheckSubscriptionStatus extends MovieDetailEvent {}

class GetMovieStreamUrl extends MovieDetailEvent {
  final String url;
  GetMovieStreamUrl({required this.url});
}