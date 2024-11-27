// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;
  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(controller: controller),
      ),
    );
  }
}
