import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/videos/controller/video_provider.dart';
import 'package:provider/provider.dart';

class ViddoCardWidget extends StatelessWidget {
  String youtubeUrl;
  String title;
  String author;
  String thumbnail_url;
  ViddoCardWidget(
      {super.key,
      required this.youtubeUrl,
      required this.title,
      required this.author,
      required this.thumbnail_url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<VideoProvider>(
        builder: (context, videoProvider, child) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                color: ConstantColor.secondaryColor,
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: thumbnail_url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ConstantColor.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$author",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
