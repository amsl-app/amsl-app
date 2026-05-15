import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari.dart';
import 'package:amsl_app/models/tori/quiz/score.dart';
import 'package:amsl_app/providers/hikari_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz_score.g.dart';

@Riverpod(keepAlive: true, dependencies: [HikariPod])
class QuizScoreProvider extends _$QuizScoreProvider {
  @override
  Future<List<Score>> build() async {
    final hikari = ref.watch(hikariPodProvider);
    return await _loadScores(hikari);
  }

  Future<List<Score>> _loadScores(Hikari hikari) async {
    try {
      final score = await hikari.quizApi.loadScores();
      return score.map((e) => Score.fromHikari(e)).toList();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => _loadScores(hikari));
    }
  }

  Future<List<Score>> _loadScoresByModule(
    Hikari hikari,
    String moduleId,
  ) async {
    try {
      final module_scores = await hikari.quizApi.loadModuleScores(moduleId);
      return module_scores.map((e) => Score.fromHikari(e)).toList();
    } on HikariException catch (e) {
      throw e.copyWith(resolve: () => _loadScoresByModule(hikari, moduleId));
    }
  }

  Future<void> reloadScoresByModule(String moduleId) async {
    final hikari = ref.read(hikariPodProvider);
    final module_scores = await _loadScoresByModule(hikari, moduleId);

    update((state) async {
      final currentScores = state;
      final filteredScores = currentScores
          .where((score) => score.moduleId != moduleId)
          .toList();
      return [...filteredScores, ...module_scores];
    });
  }

  Future<void> reloadScores() async {
    ref.invalidateSelf();
  }
}
