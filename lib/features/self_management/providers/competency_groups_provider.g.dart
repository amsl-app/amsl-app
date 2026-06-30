// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competency_groups_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(competencyGroups)
final competencyGroupsProvider = CompetencyGroupsProvider._();

final class CompetencyGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<ScoreEntry>>>,
          Map<String, List<ScoreEntry>>,
          FutureOr<Map<String, List<ScoreEntry>>>
        >
    with
        $FutureModifier<Map<String, List<ScoreEntry>>>,
        $FutureProvider<Map<String, List<ScoreEntry>>> {
  CompetencyGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competencyGroupsProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[assessmentSessionsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          CompetencyGroupsProvider.$allTransitiveDependencies0,
          CompetencyGroupsProvider.$allTransitiveDependencies1,
          CompetencyGroupsProvider.$allTransitiveDependencies2,
          CompetencyGroupsProvider.$allTransitiveDependencies3,
          CompetencyGroupsProvider.$allTransitiveDependencies4,
        },
      );

  static final $allTransitiveDependencies0 = assessmentSessionsProvider;
  static final $allTransitiveDependencies1 =
      AssessmentSessionsProvider.$allTransitiveDependencies0;
  static final $allTransitiveDependencies2 =
      AssessmentSessionsProvider.$allTransitiveDependencies1;
  static final $allTransitiveDependencies3 =
      AssessmentSessionsProvider.$allTransitiveDependencies2;
  static final $allTransitiveDependencies4 =
      AssessmentSessionsProvider.$allTransitiveDependencies3;

  @override
  String debugGetCreateSourceHash() => _$competencyGroupsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<ScoreEntry>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<ScoreEntry>>> create(Ref ref) {
    return competencyGroups(ref);
  }
}

String _$competencyGroupsHash() => r'7ff693f77da5e3d5fa6abcd692d7478b9ae83499';
