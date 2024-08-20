import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:health_horizon_webos/constants/constants.dart';
import 'package:health_horizon_webos/presentation/videos/controller/video_provider.dart';
import 'package:health_horizon_webos/widgets/custom_loading.dart';
import 'package:health_horizon_webos/widgets/video_card.dart';
import 'package:provider/provider.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
    final videoProvider = Provider.of<VideoProvider>(context, listen: false);
    videoProvider.initVideos(
      [
        "https://www.youtube.com/watch?v=eFDZOoVB2Ek",
        "https://www.youtube.com/watch?v=D-YDEyuDxWU",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=eFDZOoVB2Ek",
        "https://www.youtube.com/watch?v=D-YDEyuDxWU",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=eFDZOoVB2Ek",
        "https://www.youtube.com/watch?v=D-YDEyuDxWU",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=eFDZOoVB2Ek",
        "https://www.youtube.com/watch?v=D-YDEyuDxWU",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
        "https://www.youtube.com/watch?v=WcIcVapfqXw",
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Videos",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  childAspectRatio: 16 / 14,
                  mainAxisSpacing: 20,
                ),
                itemCount: videoProvider.videos.length,
                itemBuilder: (context, index) {
                  if (videoProvider.videos.isEmpty) {
                    return CustomCircularLoading();
                  }
                  return Bounceable(
                    onTap: () async {
                      launchExternalUrl(videoProvider.videos[index].videoUrl!);
                    },
                    child: ViddoCardWidget(
                      youtubeUrl: videoProvider.videos[index].videoUrl!,
                      author: videoProvider.videos[index].author!,
                      thumbnail_url: videoProvider.videos[index].thumbnail!,
                      title: videoProvider.videos[index].title!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
