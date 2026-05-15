import 'package:amsl_app/features/modules/widgets/session_card.dart';
import 'package:amsl_app/features/modules/widgets/session_course_card.dart';
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:flutter/material.dart';
import '../../../models/hikari/modules/module_category.dart';
import '../../../models/tori/modules/session.dart';

class SessionList extends StatelessWidget {
  SessionList({super.key, required Module module, this.onChat})
    : sessions = module.sessions.values
          .where((session) => !session.hide)
          .toList(growable: false),
      courseModule = module.category == ModuleCategory.course;

  final List<Session> sessions;
  final Function(Session)? onChat;
  final bool courseModule;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sessions
          .map((session) {
            final module = session.module.target!;
            if (courseModule) {
              return SessionCourseCard(
                session: session,
                // We show the banner if its a learning module
                showBanner: module.category == ModuleCategory.learning,
                first: sessions.first == session,
                last: sessions.last == session,
                index: sessions.indexOf(session),
                onChat: () => onChat?.call(session),
              );
            }
            return SessionCard(
              session: session,
              index: sessions.indexOf(session),
              onChat: () => onChat?.call(session),
            );
          })
          .toList(growable: false),
    );
  }
}
