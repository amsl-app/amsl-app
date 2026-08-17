// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessments.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssessmentPod)
final assessmentPodProvider = AssessmentPodProvider._();

final class AssessmentPodProvider
    extends $AsyncNotifierProvider<AssessmentPod, Map<String, Assessment>> {
  AssessmentPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assessmentPodProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          AssessmentPodProvider.$allTransitiveDependencies0,
          AssessmentPodProvider.$allTransitiveDependencies1,
          AssessmentPodProvider.$allTransitiveDependencies2,
          AssessmentPodProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$assessmentPodHash();

  @$internal
  @override
  AssessmentPod create() => AssessmentPod();
}

String _$assessmentPodHash() => r'efccec5dee4624d287d31674fa7a42f3681975f7';

abstract class _$AssessmentPod extends $AsyncNotifier<Map<String, Assessment>> {
  FutureOr<Map<String, Assessment>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, Assessment>>,
              Map<String, Assessment>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, Assessment>>,
                Map<String, Assessment>
              >,
              AsyncValue<Map<String, Assessment>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
