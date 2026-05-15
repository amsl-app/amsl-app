import 'package:amsl_app/models/hikari/modules/session.dart' as hikari_session;
import 'package:amsl_app/models/tori/modules/module.dart';
import 'package:amsl_app/models/tori/theme/module_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../models/tori/modules/session.dart';

class SessionStepper extends StatelessWidget {
  final Module module;
  final Session session;

  const SessionStepper({
    super.key,
    required this.module,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: stepList(context)),
      ),
    );
  }

  List<Widget> stepList(BuildContext context) {
    List<SessionStep> steps = [];

    for (int i = 0; i < module.sessions.values.length; i++) {
      steps.add(
        SessionStep(
          session: module.sessions.values.toList()[i],
          currentId: module.sessions.values.toList()[i].index,
          first: i == 0,
          last: i == module.sessions.values.length - 1,
        ),
      );
    }

    return steps;
  }
}

class SessionStep extends StatelessWidget {
  final Session session;
  final int currentId;

  final bool first;
  final bool last;

  const SessionStep({
    super.key,
    required this.session,
    required this.currentId,
    required this.first,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moduleTheme = theme.moduleTheme;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: VerticalDivider(
                  color: first ? Colors.transparent : Colors.white,
                  thickness: 2,
                ),
              ),
              (session.index != currentId)
                  ? Icon(
                      Icons.circle,
                      size: 20,
                      color:
                          session.status ==
                              hikari_session.SessionStatus.finished
                          ? moduleTheme.containerColor
                          : Colors.white,
                    )
                  : Stack(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          size: 20,
                          color: moduleTheme.containerColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: moduleTheme.containerColor,
                          ),
                        ),
                      ],
                    ),
              Expanded(
                child: VerticalDivider(
                  color: last ? Colors.transparent : Colors.white,
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 30,
                child: VerticalDivider(
                  color: last ? Colors.transparent : Colors.white,
                  thickness: 2,
                ),
              ),
            ],
          ),
          const Gap(5),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodySmall!.copyWith(
                  color: moduleTheme.textColor,
                ),
                text: session.title,
                children: (session.subtitle != null)
                    ? [
                        TextSpan(
                          text: " - ${session.subtitle}",
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: moduleTheme.descriptionColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
