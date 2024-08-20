import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimatedImages extends StatefulWidget {
  final List<String> imagePaths;

  const AnimatedImages({super.key, required this.imagePaths});

  @override
  _AnimatedImagesState createState() => _AnimatedImagesState();
}

class _AnimatedImagesState extends State<AnimatedImages> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://health-horizon-backend.onrender.com/images/${widget.imagePaths[_currentIndex]}",
      fit: BoxFit.cover,
    );
  }
}
