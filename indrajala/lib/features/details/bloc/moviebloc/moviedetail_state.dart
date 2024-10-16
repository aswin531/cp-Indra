import 'package:equatable/equatable.dart';
import 'package:indrajala/features/details/data/models/movieDetail_model.dart';

abstract class MovieDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movie;
  

  MovieDetailLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

class TrailerLoading extends MovieDetailState {}

class TrailerLoaded extends MovieDetailState {
  final String trailerUrl;

  TrailerLoaded({required this.trailerUrl});

  @override
  List<Object> get props => [trailerUrl];
}

class TrailerError extends MovieDetailState {
  final String message;

  TrailerError({required this.message});

  @override
  List<Object> get props => [message];
}

class SubscriptionStatusChecked extends MovieDetailState {
  final bool isSubscribed;

  SubscriptionStatusChecked({required this.isSubscribed});

  @override
  List<Object> get props => [isSubscribed];
}


class MovieStreamUrlLoaded extends MovieDetailState {
  final String streamUrl;

  MovieStreamUrlLoaded({required this.streamUrl});

  @override
  List<Object> get props => [streamUrl];
}
