import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_markdown_plus_latex/flutter_markdown_plus_latex.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.text, {
    super.key,
    this.baseTextStyle,
    this.textAlign = WrapAlignment.start,
  });

  final TextStyle? baseTextStyle;
  final WrapAlignment textAlign;
  final String text;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle =
        this.baseTextStyle ?? Theme.of(context).textTheme.bodyMedium!;

    final boldTextStyle = baseTextStyle.copyWith(fontWeight: FontWeight.w900);
    final headerTextStyle = boldTextStyle.copyWith(
      fontSize: boldTextStyle.fontSize! * 1.2,
      fontWeight: FontWeight.w900,
    );
    final italicTextStyle = baseTextStyle.copyWith(fontStyle: FontStyle.italic);
    final delTextStyle = baseTextStyle.copyWith(
      decoration: TextDecoration.lineThrough,
    );
    final linkTextStyle = baseTextStyle.copyWith(
      decoration: TextDecoration.underline,
    );
    final codeTextStyle = italicTextStyle.copyWith(
      backgroundColor: Colors.grey[200],
    );
    final imageTextStyle = baseTextStyle.copyWith(
      color: baseTextStyle.color!.withValues(alpha: 0.6),
    );
    final boxStyle = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(4),
    );

    return MarkdownBody(
      builders: {
        'latex': LatexElementBuilder(
          textStyle: baseTextStyle,
          textScaleFactor: 1.2,
        ),
      },
      data: text,
      extensionSet: md.ExtensionSet(
        [LatexBlockSyntax()],
        [LatexInlineSyntax()],
      ),
      styleSheet: MarkdownStyleSheet(
        p: baseTextStyle,
        listBullet: baseTextStyle,
        a: linkTextStyle,
        em: italicTextStyle,
        strong: boldTextStyle,
        del: delTextStyle,
        h1: headerTextStyle,
        h2: headerTextStyle,
        h3: headerTextStyle,
        h4: headerTextStyle,
        h5: headerTextStyle,
        h6: baseTextStyle,
        code: codeTextStyle,
        blockquote: imageTextStyle,
        img: imageTextStyle,
        checkbox: imageTextStyle,
        tableHead: boldTextStyle,
        tableBody: baseTextStyle,
        codeblockDecoration: boxStyle,
        blockquoteDecoration: boxStyle,
        textAlign: textAlign,
        h1Align: textAlign,
        h2Align: textAlign,
        h3Align: textAlign,
        h4Align: textAlign,
        h5Align: textAlign,
        h6Align: textAlign,
        codeblockAlign: textAlign,
      ),
      onTapLink: (text, href, title) async {
        if (href != null) {
          final uri = Uri.parse(href);
          await launchUrl(uri);
        }
      },
    );
  }
}
