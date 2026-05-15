import 'dart:async';
import 'dart:math';
import 'package:amsl_app/features/preferences/preferences.dart';
import 'package:amsl_app/models/hikari/modules/session.dart' as hikari_session;
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:amsl_app/models/tori/theme/session_theme.dart';
import 'package:amsl_app/widgets/error/error_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import '../../../models/tori/modules/session.dart';
import '../../../widgets/cached_image.dart';
import 'lock_tool_tip.dart';

class SessionCourseCard extends StatefulHookConsumerWidget {
  static final log = Logger("SessionCourseCard");

  const SessionCourseCard({
    super.key,
    required this.session,
    required this.showBanner,
    required this.first,
    required this.last,
    required this.index,
    this.onChat,
  });

  final Session session;
  final int index;
  final bool showBanner;
  final bool first;
  final bool last;
  final VoidCallback? onChat;

  @override
  ConsumerState<SessionCourseCard> createState() => _SessionCourseCardState();
}

class _SessionCourseCardState extends ConsumerState<SessionCourseCard> {
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

    SessionCourseCard.log.fine(
      "Initializing session course card ${widget.session.id}, locked: $locked",
    );
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

    const br = BorderRadius.all(Radius.circular(16));
    const double thickness = 3.0;
    const double maxHeight = 150;
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: br,
      onTap: (!locked || activateClickableSession)
          ? widget.onChat
          : () => showMessage(context, label: text),
      child: Padding(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildIcon(),
                          buildStatusIndicator(),
                          Expanded(
                            child: VerticalDivider(
                              color: theme.moduleTheme.color,
                              thickness: thickness,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: VerticalDivider(
                              color: theme.moduleTheme.color,
                              thickness: thickness,
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      Expanded(child: buildText(maxHeight: maxHeight)),
                    ],
                  ),
                ),
              ),
              if (widget.showBanner) Flexible(flex: 1, child: buildBanner()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon() {
    final theme = Theme.of(context);
    if (locked) {
      final icon = Icon(
        Icons.lock_outline_rounded,
        size: 20,
        color: Colors.white,
      );
      return Stack(
        children: [
          Icon(Icons.circle, size: 40, color: theme.moduleTheme.containerColor),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: icon,
          ),
        ],
      );
    }
    if (widget.session.completion != null) {
      return Stack(
        children: [
          Icon(Icons.circle, size: 40, color: theme.moduleTheme.containerColor),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Icon(Icons.check, size: 20, color: Colors.white),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Icon(
          Icons.circle_outlined,
          size: 40,
          color: theme.moduleTheme.containerColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Icon(
            Icons.circle,
            size: 20,
            color: theme.moduleTheme.containerColor,
          ),
        ),
      ],
    );
  }

  Widget buildStatusIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.session.status == hikari_session.SessionStatus.started
                ? Colors.white
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          height: 5,
          width: 5,
        ),
      ],
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

    return Container(padding: const EdgeInsets.only(left: 16), child: child);
  }
}
