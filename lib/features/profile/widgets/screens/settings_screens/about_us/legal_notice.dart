import 'package:flutter/material.dart';

class LegalNotice extends StatefulWidget {
  const LegalNotice({super.key});

  @override
  State<LegalNotice> createState() => _LegalNoticeState();
}

class _LegalNoticeState extends State<LegalNotice> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Impressum",
                  style: TextStyle(color: theme.colorScheme.surfaceContainer),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: []),
        ),
      ),
    );
  }
}
