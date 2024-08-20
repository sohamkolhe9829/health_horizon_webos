import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

String APIKey =
    "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";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/chat/completions";

//Health Horizon Backend API Endpoint
  // static String apiEndPoint = "http://192.168.31.136:5858/"; //Samsung F23
  static String apiEndPoint =
      "https://health-horizon-backend.onrender.com/"; //Render Hosted Endpoint

  static Map<String, String> header = {
    "Content-Type": 'application/json',
    "Authorization": "Bearer $APIKey"
  };
  static sendMessage(String? message) async {
    var res = await http.post(
      Uri.parse(baseUrl),
      headers: header,
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "prompt": "$message",
        // 'temperature': 0,
        // "max_tokens": 100,
        // "top_p": 1,
        // "frequency_penalty": 0.0,
        // "presense_penalty": 0.0,
        // "stop": [" Human:", " AI:"]
      }),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
    } else {
      print("Failed to fetch response ${res.body}");
    }
  }

  static Future<String?> getYoutubeVideoUrl(String videoId) async {
    var yt = YoutubeExplode();
    try {
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var streamInfo = manifest.muxed.withHighestBitrate();
      return streamInfo.url.toString();
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {
      yt.close();
    }
  }
}
