import 'package:chewie/chewie.dart';

abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerLoaded extends VideoPlayerState {
  final ChewieController chewieController;

  VideoPlayerLoaded(this.chewieController);
}

class VideoPlayerError extends VideoPlayerState {
  final String errorMessage;

  VideoPlayerError(this.errorMessage);
}
