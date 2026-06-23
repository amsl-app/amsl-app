import 'package:amsl_app/features/modules/providers/module_configuration.dart';
import 'package:amsl_app/features/quiz/providers/quiz_score.dart';
import 'package:amsl_app/models/hikari/modules/module_category.dart';
import 'package:amsl_app/models/tori/modules/module_assessment.dart';
import 'package:amsl_app/models/tori/modules/module_themes.dart';
import 'package:amsl_app/models/tori/quiz/score.dart';
import 'package:amsl_app/screens/home/home_chip.dart';
import 'package:amsl_app/widgets/async_value_extension.dart';
import 'package:amsl_app/widgets/buttons/rounded_corner_button.dart';
import 'package:amsl_app/widgets/loading/skeleton_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleHomeCard extends HookConsumerWidget {
  const ModuleHomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncModules = ref.watch(moduleConfigurationProviderProvider);
    final pageController = usePageController();
    final currentPage = useState(0);
    useListenable(pageController);

    return asyncModules.build(
      context,
      builder: (context, moduleConfig) {
        final modules = moduleConfig!.shownModules.toList();
        if (modules.isEmpty) return const SizedBox.shrink();

        final bgColor = _interpolateColor(modules, pageController);
        final pageHeight = MediaQuery.of(context).size.height * 0.26;

        final currentModule = modules[currentPage.value];
        final groupKey = currentModule.module.groups.isNotEmpty
            ? currentModule.module.groups.first
            : null;
        final groupLabel = groupKey != null
            ? moduleConfig.groups[groupKey]?.label
            : null;

        return AnimatedContainer(
          duration: Duration.zero,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    HomeChip(
                      label: 'Module',
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      textColor: Colors.white,
                    ),
                    if (groupLabel != null) ...[
                      const Gap(8),
                      HomeChip(
                        label: groupLabel,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        textColor: Colors.white,
                      ),
                    ],
                    const Spacer(),
                    const Icon(Icons.school_outlined, color: Colors.white),
                  ],
                ),
                const Gap(16),
                SizedBox(
                  height: pageHeight,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (i) => currentPage.value = i,
                    itemCount: modules.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: _ModulePage(module: modules[i]),
                    ),
                  ),
                ),
                if (modules.length > 1) ...[
                  const Gap(8),
                  _PageDots(count: modules.length, current: currentPage.value),
                ],
              ],
            ),
          ),
        );
      },
      loadingBuilder: (context) => _buildLoading(),
      errorBuilder: (context, _, _) => _buildLoading(),
    );
  }

  Color _getModuleColor(ModuleAssessmentSet module) =>
      module.module.theme?.color ?? ModuleThemes.blue.color;

  Color _interpolateColor(
    List<ModuleAssessmentSet> modules,
    PageController controller,
  ) {
    if (!controller.hasClients || modules.length == 1) {
      return _getModuleColor(modules.first);
    }
    final page = controller.page ?? 0.0;
    final left = page.floor().clamp(0, modules.length - 1);
    final right = (left + 1).clamp(0, modules.length - 1);
    final t = page - page.floor();
    return Color.lerp(
      _getModuleColor(modules[left]),
      _getModuleColor(modules[right]),
      t,
    )!;
  }

  Widget _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        color: ModuleThemes.blue.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SkeletonLoadingWidget(
          columns: 1,
          rows: 1,
          color: ModuleThemes.blue.color,
        ),
      ),
    );
  }
}

class _ModulePage extends ConsumerWidget {
  const _ModulePage({required this.module});

  final ModuleAssessmentSet module;

  double _progress() {
    if (module.completion != null) return 1.0;
    int base = module.module.sessions.length;
    if (module.postAssessment.isDefined) base++;
    if (base == 0) return 0;
    return (module.sessionsDone / base).clamp(0.0, 1.0);
  }

  int _bloomLevel(List<Score> scores) {
    final total = scores
        .where((s) => s.moduleId == module.module.id)
        .fold(0, (sum, s) => sum + s.score)
        .toDouble();
    return switch (total) {
      < 5.0 => 1,
      < 10.0 => 2,
      < 15.0 => 3,
      < 20.0 => 4,
      < 25.0 => 5,
      < 30.0 => 6,
      _ => 7,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isCourse = module.module.category == ModuleCategory.course;
    final isQuizzable = module.module.quizzable;
    final asyncScores = ref.watch(quizScoreProviderProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          module.module.title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (module.module.subtitle != null ||
            module.module.description != null) ...[
          const Gap(4),
          Text(
            module.module.subtitle ?? module.module.description!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
            maxLines: isCourse ? 4 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (isQuizzable) ...[
          const Gap(10),
          asyncScores.build(
            context,
            builder: (ctx, scores) =>
                _BloomRow(level: _bloomLevel(scores ?? [])),
            loadingBuilder: (ctx) => const SizedBox.shrink(),
            errorBuilder: (ctx, _, _) => const SizedBox.shrink(),
          ),
        ],
        const Spacer(),

        if (isCourse) ...[
          const Gap(14),
          _ProgressRow(
            done: module.sessionsDone,
            total: module.module.sessions.length,
            progress: _progress(),
          ),
        ],

        const Gap(8),
        _ActionRow(module: module),
        const Gap(8),
        RoundedCornerButton(
          label: 'Details',
          icon: Icons.arrow_forward,
          buttonColor: Colors.white.withValues(alpha: 0.15),
          labelColor: Colors.white,
          onTap: () => context.goNamed(
            'module',
            pathParameters: {'moduleID': module.module.id},
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.module});

  final ModuleAssessmentSet module;

  @override
  Widget build(BuildContext context) {
    final isQuizzable = module.module.quizzable;
    final selfLearningSession = module.module.selfLearning
        ? module.module.sessions['self-learning']
        : null;

    if (!isQuizzable && selfLearningSession == null) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        if (isQuizzable)
          Expanded(
            child: RoundedCornerButton(
              label: 'Quiz starten',
              buttonColor: Colors.white.withValues(alpha: 0.2),
              labelColor: Colors.white,
              icon: Icons.question_mark_outlined,
              onTap: () => context.pushNamed('quiz'),
            ),
          ),
        if (isQuizzable && selfLearningSession != null) const Gap(8),
        if (selfLearningSession != null)
          Expanded(
            child: RoundedCornerButton(
              label: 'Freies Lernen',
              icon: Icons.forum_outlined,
              buttonColor: Colors.white.withValues(alpha: 0.2),
              labelColor: Colors.white,
              onTap: () => context.pushNamed(
                'chat',
                pathParameters: {
                  'moduleID': selfLearningSession.module.target!.id,
                  'sessionID': selfLearningSession.id,
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.done,
    required this.total,
    required this.progress,
  });

  final int done;
  final int total;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fortschritt',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            Text(
              '$done / $total Einheiten',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        const Gap(6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 12,
          ),
        ),
      ],
    );
  }
}

class _BloomRow extends StatelessWidget {
  const _BloomRow({required this.level});

  final int level;

  static const _bloomNames = [
    'Erinnern',
    'Verstehen',
    'Anwenden',
    'Analysieren',
    'Bewerten',
    'Erschaffen',
    'Meister',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = level >= 1 && level <= _bloomNames.length
        ? _bloomNames[level - 1]
        : '';

    return Row(
      children: [
        Text(
          'Bloom',
          style: theme.textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const Gap(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Level $level / 7 · $name',
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: i == current ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
