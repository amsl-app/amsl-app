import 'package:amsl_app/widgets/loading/loading_card.dart';
import 'package:flutter/material.dart';

class SkeletonLoadingWidget extends StatelessWidget {
  const SkeletonLoadingWidget({
    super.key,
    this.rows = 2,
    this.columns = 1,
    this.width,
    this.color,
  });

  final int rows;
  final int columns;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cardWith =
        width ?? (MediaQuery.of(context).size.width / columns) - 16 * (columns);

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: List.generate(
        rows * columns,
        (index) => LoadingCard(width: cardWith, color: color),
      ),
    );
  }
}
