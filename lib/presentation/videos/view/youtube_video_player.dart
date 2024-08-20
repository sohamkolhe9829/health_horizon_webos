import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/videos/controller/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeVideoId;

  YoutubeVideoPlayer({required this.youtubeVideoId});

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  @override
  void initState() {
    super.initState();
    final videoProvider = Provider.of<VideoProvider>(context, listen: false);
    videoProvider.initializeVideo(widget.youtubeVideoId);
  }

  // @override
  // void dispose() {
  //   final videoProvider = Provider.of<VideoProvider>(context, listen: false);
  //   videoProvider.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, videoProvider, child) => videoProvider.isInitialized
          ? Scaffold(
              appBar: AppBar(),
              body: AspectRatio(
                aspectRatio: videoProvider.controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(
                      videoProvider.controller,
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          videoProvider.playPauseVideo();
                        },
                        icon: Icon(videoProvider.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
