abstract class VideoPlayerEvent {}

class InitializeVideo extends VideoPlayerEvent {
  final String url;

  InitializeVideo(this.url);
}
