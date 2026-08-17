import 'package:amsl_app/themes/chat_theme.dart';
import 'package:amsl_app/widgets/loading/loading_card.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatefulWidget {
  const VideoMessage({required this.uri, super.key});

  final Uri uri;

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  late final VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(widget.uri);
    _videoController.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          allowFullScreen: true,
        );
      });
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).chatTheme;
    final theme = chatTheme.otherBubbles;
    const double br = 12;

    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(br),
        child: Container(
          color: theme.backgroundColor,
          padding: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(br),
            child: _chewieController == null
                ? LoadingCard(width: 200, height: 200)
                : AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  ),
          ),
        ),
      ),
    );
  }
}
