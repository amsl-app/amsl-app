import 'package:amsl_app/themes/chat_theme.dart';
import 'package:amsl_app/widgets/text/markdown_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../models/message.dart';

Widget buildChatBubble({
  required Widget message,
  required Sender sender,
  required bool showIcon,
  required bool showEdge,
  Color? color,
}) {
  const double iconSize = 30;
  const double edgeSize = 20;

  SvgPicture icon = SvgPicture.asset(
    "assets/images/avatar_images/avatar_centered.svg",
    height: iconSize,
  );

  if (showIcon & showEdge) {
    //has to be amsl
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        icon,
        BubbleEdge(sentByMe: false, size: edgeSize, color: color),
        Expanded(child: message),
      ],
    );
  }
  if (showIcon) {
    //has to be amsl
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        icon,
        Expanded(child: message),
      ],
    );
  }
  if (showEdge) {
    //self or last amsl before typing
    if (sender == Sender.self) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: message),
          BubbleEdge(sentByMe: true, size: edgeSize, color: color),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(iconSize),
        BubbleEdge(sentByMe: false, size: edgeSize, color: color),
        Expanded(child: message),
      ],
    );
  }
  if (sender == Sender.self) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [message, const Gap(edgeSize)],
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [const Gap(iconSize + edgeSize), message],
  );
}

class Bubble extends StatelessWidget {
  const Bubble(
    this.message,
    this.sentByMe, {
    super.key,
    this.color,
    this.fontColor,
    this.onPressed,
  });

  final String message;
  final bool sentByMe;
  final Color? color;
  final Color? fontColor;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).chatTheme;
    final theme = sentByMe ? chatTheme.ownBubbles : chatTheme.otherBubbles;

    final baseTextStlye = theme.textStyle.copyWith(
      color: fontColor ?? theme.textStyle.color,
    );

    final WrapAlignment textAlign = sentByMe
        ? WrapAlignment.end
        : WrapAlignment.start;
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: color ?? theme.backgroundColor,
            child: Ink(
              child: InkWell(
                onTap: onPressed == null ? null : () => onPressed!(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: MarkdownText(
                    message,
                    baseTextStyle: baseTextStlye,
                    textAlign: textAlign,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BubbleEdge extends StatelessWidget {
  final bool sentByMe;
  final double size;
  final Color? color;

  const BubbleEdge({
    super.key,
    required this.sentByMe,
    required this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).chatTheme;
    final theme = sentByMe ? chatTheme.ownBubbles : chatTheme.otherBubbles;

    return Column(
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: BubbleEdgePainter(
            color: color ?? theme.backgroundColor,
            sentByMe: sentByMe,
          ),
        ),
        const Gap(10),
      ],
    );
  }
}

class BubbleEdgePainter extends CustomPainter {
  final Color color;
  final bool sentByMe;

  const BubbleEdgePainter({required this.color, required this.sentByMe});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    double startX = 5;
    double startY = size.height / 1.5;

    path.moveTo(startX, startY);
    path.cubicTo(startX + 5, startY, size.width, 5, size.width, 0);
    path.lineTo(size.width, size.height);

    if (sentByMe) {
      canvas.scale(-1, 1);
      canvas.translate(-size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
