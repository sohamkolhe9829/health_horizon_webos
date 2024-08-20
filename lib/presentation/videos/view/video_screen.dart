import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/side_panel.dart';
import 'package:health_horizon_webos/presentation/videos/view/video_widget.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidePanel(selectedIndex: 2),
          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(5)),
            height: MediaQuery.of(context).size.height,
          ),
          const Flexible(
            flex: 4,
            child: VideoWidget(),
          ),
        ],
      ),
    );
  }
}
