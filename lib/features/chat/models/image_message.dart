import 'message.dart';

class ImageMessage extends Message {
  final Uri uri;

  const ImageMessage({
    required this.uri,
    required super.sender,
    super.onPressed,
  });
}
