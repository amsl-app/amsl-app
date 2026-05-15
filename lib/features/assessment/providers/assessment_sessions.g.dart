// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_sessions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssessmentSessions)
final assessmentSessionsProvider = AssessmentSessionsProvider._();

final class AssessmentSessionsProvider
    extends
        $AsyncNotifierProvider<
          AssessmentSessions,
          Map<String, ToriAssessmentSession>
        > {
  AssessmentSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assessmentSessionsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AssessmentSessionsProvider.$allTransitiveDependencies0,
          AssessmentSessionsProvider.$allTransitiveDependencies1,
          AssessmentSessionsProvider.$allTransitiveDependencies2,
          AssessmentSessionsProvider.$allTransitiveDependencies3,
        },
      );

  static final $allTransitiveDependencies0 = hikariPodProvider;
  static final $allTransitiveDependencies1 =
      HikariPodProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      HikariPodProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      HikariPodProvider.$allTransitiveDependencies2;

  @override
  String debugGetCreateSourceHash() => _$assessmentSessionsHash();

  @$internal
  @override
  AssessmentSessions create() => AssessmentSessions();
}

String _$assessmentSessionsHash() =>
    r'f9b41574303eb13022c8812e83afbad81d1b44ea';

abstract class _$AssessmentSessions
    extends $AsyncNotifier<Map<String, ToriAssessmentSession>> {
  FutureOr<Map<String, ToriAssessmentSession>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, ToriAssessmentSession>>,
              Map<String, ToriAssessmentSession>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, ToriAssessmentSession>>,
                Map<String, ToriAssessmentSession>
              >,
              AsyncValue<Map<String, ToriAssessmentSession>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
