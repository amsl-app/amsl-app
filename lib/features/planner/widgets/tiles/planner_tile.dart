import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PlannerTile extends StatelessWidget {
  const PlannerTile({
    super.key,
    required this.dismissibleKey,
    required this.color,
    required this.borderColor,
    required this.onTap,
    required this.onDelete,
    required this.leading,
    required this.children,
    this.leadingGap = 8,
    this.trailing,
  });

  final Key dismissibleKey;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  final Widget leading;
  final double leadingGap;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Dismissible(
        key: dismissibleKey,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: theme.colorScheme.error,
            borderRadius: borderRadius,
          ),
          child: Icon(Icons.delete_outline, color: theme.colorScheme.onError),
        ),
        confirmDismiss: (_) async {
          onDelete();
          return true;
        },
        child: Material(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: BorderSide(color: borderColor),
          ),
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  leading,
                  Gap(leadingGap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: children,
                    ),
                  ),
                  if (trailing != null) ...[const Gap(8), trailing!],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlannerTileMetaRow extends StatelessWidget {
  const PlannerTileMetaRow({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(4),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
