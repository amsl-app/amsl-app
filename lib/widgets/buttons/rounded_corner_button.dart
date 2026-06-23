import 'package:flutter/material.dart';

class RoundedCornerButton extends StatefulWidget {
  final Color buttonColor;
  final Color labelColor;
  final Color? borderColor;
  final IconData? icon;
  final Function()? onTap;
  final String label;
  final MainAxisSize mainAxisSize;

  const RoundedCornerButton({
    super.key,
    required this.label,
    this.buttonColor = const Color(0xFF0C132A),
    this.labelColor = const Color(0xFFFFFFFF),
    this.mainAxisSize = MainAxisSize.max,
    this.borderColor,
    this.icon,
    required this.onTap,
  });

  @override
  State<RoundedCornerButton> createState() => _RoundedCornerButtonState();
}

class _RoundedCornerButtonState extends State<RoundedCornerButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: widget.mainAxisSize,
          children: [
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: loading ? Colors.transparent : widget.labelColor,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: 8),
              Icon(
                size: 16,
                widget.icon,
                color: loading ? Colors.transparent : widget.labelColor,
              ),
            ],
          ],
        ),
        if (loading)
          Center(
            child: SizedBox(
              height: Theme.of(context).textTheme.titleSmall!.fontSize,
              width: Theme.of(context).textTheme.titleSmall!.fontSize,
              child: CircularProgressIndicator(color: widget.labelColor),
            ),
          ),
      ],
    );

    return Opacity(
      opacity: widget.onTap != null ? 1.0 : 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: widget.buttonColor,
          child: Ink(
            child: InkWell(
              onTap: () async {
                if (!loading && widget.onTap != null) {
                  setState(() {
                    loading = true;
                  });
                  try {
                    await widget.onTap!();
                  } catch (_) {
                    rethrow;
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: widget.borderColor != null
                      ? Border.all(color: widget.borderColor!, width: 2)
                      : null,
                ),
                padding: const EdgeInsets.all(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.mainAxisSize == MainAxisSize.min
                      ? IntrinsicWidth(child: child)
                      : child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
