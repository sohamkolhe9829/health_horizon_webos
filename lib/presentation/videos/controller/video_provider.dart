import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/videos/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../services/api_services.dart';

class VideoProvider with ChangeNotifier {
  List<VideoModel> videos = [];

  initVideos(List urls) {
    videos.clear();
    for (var i = 0; i < urls.length; i++) {
      getVideoDetails(urls[i]);
    }
    // notifyListeners();
  }

  getVideoDetails(String videoUrl) async {
    final response = await http.get(
        Uri.parse('https://www.youtube.com/oembed?url=$videoUrl&format=json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      print(data.toString());
      print(data['author_name']);

      videos.add(
        VideoModel(
          title: data['title'],
          author: data['author_name'],
          html: data['html'],
          thumbnail: data['thumbnail_url'],
          videoUrl: videoUrl,
        ),
      );
      notifyListeners();
    } else {
      throw Exception('Failed to fetch video details');
    }
  }

  late VideoPlayerController controller;
  bool isInitialized = false;

  bool isPlaying = false;
  Future<void> initializeVideo(String videoId) async {
    String? videoUrl = await ApiServices.getYoutubeVideoUrl(videoId);
    if (videoUrl != null) {
      controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          isInitialized = true;
          notifyListeners();

          controller.play();
          isPlaying = true;
          notifyListeners();
        });
    }
  }

  playPauseVideo() {
    isPlaying ? controller.pause() : controller.play();
    notifyListeners();
  }
}
