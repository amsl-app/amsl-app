import 'message.dart';

class VideoMessage extends Message {
  final Uri uri;

  const VideoMessage({
    required this.uri,
    required super.sender,
    super.onPressed,
  });
}
