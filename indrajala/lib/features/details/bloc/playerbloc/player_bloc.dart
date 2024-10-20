import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indrajala/features/details/bloc/playerbloc/player_event.dart';
import 'package:indrajala/features/details/bloc/playerbloc/player_state.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoPlayerInitial()) {
    on<InitializeVideo>(_onInitializeVideo);
  }

  Future<void> _onInitializeVideo(
    InitializeVideo event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(VideoPlayerLoading());

    try {
      
      final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(event.url));
      
      await videoPlayerController.initialize();
      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
      emit(VideoPlayerLoaded(chewieController));
    } catch (e) {
      emit(VideoPlayerError("Failed to load video: $e"));
    }
  }

  @override
  Future<void> close() {
    // Dispose of controllers when the bloc is closed
    final state = this.state;
    if (state is VideoPlayerLoaded) {
      state.chewieController.dispose();
    }
    return super.close();
  }
}