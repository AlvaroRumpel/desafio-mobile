import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../components/custom_space.dart';
import '../../../../core/shared/dtos/video_dto.dart';
import '../../../../core/theme/custom_theme.dart';

class VideoViewPage extends StatefulWidget {
  const VideoViewPage({super.key, required this.video});
  final VideoDto video;

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late final VideoPlayerController _controller;
  late final ChewieController _chewieController;

  @override
  void initState() {
    try {
      _initializePlayer();
    } catch (e) {
      log('Error on generate the video', error: e);
    }

    super.initState();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.uri));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
      autoInitialize: true,
      errorBuilder: (context, error) {
        return Center(
          child: Text('Error: $error'),
        );
      },
    );
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Imagens',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          iconSize: 16,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.video.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ThemeColors.primary,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
            const CustomSpace.sp2(),
            Text(
              widget.video.subtitle,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const CustomSpace.sp4(),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Visibility(
                visible: _controller.value.isInitialized,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Chewie(controller: _chewieController),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
