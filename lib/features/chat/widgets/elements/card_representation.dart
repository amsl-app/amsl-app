import 'package:amsl_app/themes/chat_theme.dart';
import 'package:flutter/material.dart';

import 'card_button.dart';

class CardRepresentation extends StatelessWidget {
  const CardRepresentation({
    required this.imageUrl,
    required this.title,
    required this.button,
    super.key,
  });

  final String imageUrl;
  final String title;
  final CardButton button;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(1),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).chatTheme.otherBubbles.backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageUrl),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 4.0,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            button,
          ],
        ),
      ),
    );
  }
}
