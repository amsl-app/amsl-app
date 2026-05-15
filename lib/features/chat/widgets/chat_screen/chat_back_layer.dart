import 'package:amsl_app/features/chat/widgets/elements/session_stepper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amsl_app/models/tori/modules/session.dart';

class ChatBackLayer extends HookConsumerWidget {
  final Session session;

  const ChatBackLayer({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2.5,
        ),
        child: SessionStepper(module: session.module.target!, session: session),
      ),
    );
  }
}
