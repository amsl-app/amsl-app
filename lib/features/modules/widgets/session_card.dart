import 'dart:async';
import 'dart:math';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/models/hikari/modules/session.dart' as hikari_session;
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/models/tori/theme/session_theme.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_icon_button.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../models/tori/modules/session.dart';
import '../../../widgets/cached_image.dart';
import 'lock_tool_tip.dart';

class SessionCard extends StatefulHookConsumerWidget {
  const SessionCard({
    super.key,
    required this.session,
    required this.index,
    this.onChat,
  });

  final Session session;
  final int index;
  final VoidCallback? onChat;

  @override
  ConsumerState<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends ConsumerState<SessionCard> {
  static final log = Logger("SessionCard");

  bool locked = true;

  late String text;

  void updateLockState() {
    if (!mounted || widget.session.unlocked) {
      locked = false;
      return;
    }

    setState(() {
      text = widget.session.lockedUntil!.unlockHint();

      // If no lock is undefined or after now => locked
      if (widget.session.lockedUntil!.type ==
              hikari_session.LockType.undefined ||
          widget.session.lockedUntil!.time!.isAfter(DateTime.now())) {
        locked = true;
        // If no lock is not undefined and before now => unlocked
      } else {
        locked = false;
        return;
      }
    });
    // Update every second
    Timer(const Duration(seconds: 1), updateLockState);
  }

  @override
  void initState() {
    super.initState();
    updateLockState();

    log.fine("Initializing session card ${widget.session.id}, locked: $locked");
  }

  @override
  Widget build(BuildContext context) {
    if (locked) {
      LockTooltip(
        lockedUntil: widget.session.lockedUntil!,
        child: _build(context),
      );
    }
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final preferences = ref.read(preferencesProvider);
    final activateClickableSession =
        preferences.activateClickableSession ?? false;

    const double maxHeight = 150;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        constraints: const BoxConstraints(minHeight: 0, maxHeight: maxHeight),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBanner(),
                    Expanded(child: buildText(maxHeight: maxHeight)),
                    const Gap(8),
                    RoundedCornerIconButton(
                      active: !locked,
                      onTap: () {
                        if (!locked || activateClickableSession) {
                          widget.onChat?.call();
                        } else {
                          showMessage(context, label: text);
                        }
                      },
                      icon: !locked ? Icons.forum : Icons.lock_outline,
                      iconColore: theme.moduleTheme.textColor,
                      buttonColor: theme.moduleTheme.containerColor,
                    ),
                    const Gap(12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText({required double maxHeight}) {
    final theme = Theme.of(context);
    final sessionTheme = theme.sessionTheme;
    final title = Text(
      widget.session.title,
      style: theme.textTheme.titleSmall!.copyWith(
        color: sessionTheme.textColor,
      ),
    );
    final subtitle = Text(
      widget.session.subtitle ?? "",
      style: theme.textTheme.bodySmall!.copyWith(color: sessionTheme.textColor),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
    // final subtitle = Text(session.subtitle ?? "", style: theme.textTheme.bodySmall);
    final style = theme.textTheme.bodySmall;
    final fontSize = style!.fontSize!;
    int maxLines = max(((maxHeight / fontSize) * 0.8).floor(), 1);
    maxLines = maxLines > 0 ? maxLines : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        title,
        const Gap(2),
        Visibility(
          visible:
              widget.session.subtitle != null &&
              widget.session.subtitle!.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: subtitle,
          ),
        ),
        Text(
          widget.session.description != null ? widget.session.description! : "",
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: style.copyWith(color: sessionTheme.descriptionColor),
        ),
        const Gap(12),
      ],
    );
  }

  Widget buildBanner() {
    final Widget? child;
    final theme = Theme.of(context);
    if (widget.session.banner != null) {
      child = CachedImage(imageUrl: widget.session.banner!);
    } else {
      child = Align(
        widthFactor: 1,
        heightFactor: 1,
        alignment: Alignment.topCenter,
        child: Text(
          "${widget.index + 1}",
          style: theme.textTheme.displayMedium!.copyWith(
            color: theme.moduleTheme.textColor.withAlpha(179),
          ),
        ),
      );
    }

    return Container(padding: const EdgeInsets.only(right: 16), child: child);
  }
}
