// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_score.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuizScoreProvider)
final quizScoreProviderProvider = QuizScoreProviderProvider._();

final class QuizScoreProviderProvider
    extends $AsyncNotifierProvider<QuizScoreProvider, List<Score>> {
  QuizScoreProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizScoreProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          QuizScoreProviderProvider.$allTransitiveDependencies0,
          QuizScoreProviderProvider.$allTransitiveDependencies1,
          QuizScoreProviderProvider.$allTransitiveDependencies2,
          QuizScoreProviderProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$quizScoreProviderHash();

  @$internal
  @override
  QuizScoreProvider create() => QuizScoreProvider();
}

String _$quizScoreProviderHash() => r'3b99300e793f0635c5e350a81e11da3c0c43b4fd';

abstract class _$QuizScoreProvider extends $AsyncNotifier<List<Score>> {
  FutureOr<List<Score>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Score>>, List<Score>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Score>>, List<Score>>,
              AsyncValue<List<Score>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
