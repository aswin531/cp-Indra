// ignore_for_file: library_private_types_in_public_api
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:indrajala/core/theme/app_colors.dart';
import 'package:video_player/video_player.dart';
//VideoPlayerScreen

class VideoPlayerScreen extends StatefulWidget {
  final String trailerUrl;

  const VideoPlayerScreen({super.key, required this.trailerUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.trailerUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await _videoPlayerController.initialize();

      if (mounted) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
            showControls: true,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Colors.grey,
              bufferedColor: Colors.white,
            ),
            placeholder: Container(
              color: Colors.black,
            ),
            autoInitialize: true,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _retryInitialization(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            },
            customControls: const MaterialControls(
              showPlayButton: true,
              //showLoadingOnInitialize: false,
            ),
          );
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _retryInitialization() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }
    await _initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IAppColors.bgBlack,
      appBar: AppBar(
        backgroundColor: IAppColors.transparent,
        //title: const Text('Video Player'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _retryInitialization,
                        child: const Text('Retry'),
                      ),
                    ],
                  )
                : _chewieController != null
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController!),
                      )
                    : const Text('Failed to initialize video player',
                        style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
