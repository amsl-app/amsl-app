import 'package:amsl_app/themes/chat_theme.dart';
import 'package:amsl_app/widgets/loading/loading_card.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageMessage extends StatelessWidget {
  const ImageMessage({required this.uri, super.key});

  final Uri uri;

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
            child: InkWell(
              child: Image.network(
                uri.toString(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return LoadingCard(width: 200, height: 200);
                },
              ),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    insetPadding: const EdgeInsets.all(0),
                    child: PhotoView(
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      tightMode: true,
                      imageProvider: NetworkImage(uri.toString()),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
