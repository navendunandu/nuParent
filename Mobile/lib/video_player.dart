import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  FullScreenVideoPlayer({required this.videoUrl});

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    VideoPlayerController videoPlayerController =
        VideoPlayerController.network(widget.videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: videoPlayerController.value.aspectRatio,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Video'),
      ),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    super.dispose();
  }
}
