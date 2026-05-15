// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QuizProvider)
final quizProviderProvider = QuizProviderProvider._();

final class QuizProviderProvider
    extends $AsyncNotifierProvider<QuizProvider, List<Quiz>> {
  QuizProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizProviderProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[hikariPodProvider],
        $allTransitiveDependencies: <ProviderOrFamily>{
          QuizProviderProvider.$allTransitiveDependencies0,
          QuizProviderProvider.$allTransitiveDependencies1,
          QuizProviderProvider.$allTransitiveDependencies2,
          QuizProviderProvider.$allTransitiveDependencies3,
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
  String debugGetCreateSourceHash() => _$quizProviderHash();

  @$internal
  @override
  QuizProvider create() => QuizProvider();
}

String _$quizProviderHash() => r'cd871f2bdc28e37da24ed395a04da8b592564caa';

abstract class _$QuizProvider extends $AsyncNotifier<List<Quiz>> {
  FutureOr<List<Quiz>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Quiz>>, List<Quiz>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Quiz>>, List<Quiz>>,
              AsyncValue<List<Quiz>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
