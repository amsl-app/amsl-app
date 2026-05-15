import 'package:flutter/material.dart';

class LoadingTextButton extends StatefulWidget {
  const LoadingTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.textStyle,
  });

  final String label;
  final RefreshCallback onPressed;
  final TextStyle? textStyle;

  @override
  State<LoadingTextButton> createState() => _LoadingTextButtonState();
}

class _LoadingTextButtonState extends State<LoadingTextButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        widget.textStyle ?? Theme.of(context).textTheme.bodyMedium;
    return Stack(
      children: [
        Visibility(
          visible: loading,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: textStyle!.fontSize! * 2,
              height: textStyle.fontSize! * 2,
              child: CircularProgressIndicator(color: textStyle.color),
            ),
          ),
        ),
        Visibility(
          visible: !loading,
          child: TextButton(
            child: Text(widget.label, style: textStyle),
            onPressed: () {
              setState(() {
                loading = true;
              });
              widget.onPressed().whenComplete(() {
                setState(() {
                  loading = false;
                });
              });
            },
          ),
        ),
      ],
    );
  }
}
