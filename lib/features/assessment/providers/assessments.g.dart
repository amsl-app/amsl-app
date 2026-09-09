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
    extends $AsyncNotifierProvider<AssessmentPod, AssessmentConfiguration> {
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

String _$assessmentPodHash() => r'f1fa3ae3688320a160beec65e4a8b30ef9e4e647';

abstract class _$AssessmentPod extends $AsyncNotifier<AssessmentConfiguration> {
  FutureOr<AssessmentConfiguration> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<AssessmentConfiguration>,
              AssessmentConfiguration
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<AssessmentConfiguration>,
                AssessmentConfiguration
              >,
              AsyncValue<AssessmentConfiguration>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
