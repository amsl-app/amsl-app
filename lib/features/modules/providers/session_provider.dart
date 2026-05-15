import 'package:amsl_app/features/modules/providers/module_provider.dart';
import 'package:amsl_app/models/tori/modules/session.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_provider.g.dart';

@Riverpod(dependencies: [ModuleNotifier])
class SessionPod extends _$SessionPod {
  @override
  Session? build(String moduleID, String sessionID) {
    final session = ref.read(
      moduleProvider.select(
        (value) => value.asData?.value[moduleID]?.module.sessions[sessionID],
      ),
    );
    return session;
  }
}
