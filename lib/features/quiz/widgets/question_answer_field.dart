import 'package:amsl_app/features/quiz/widgets/multiple_choice_option.dart';
import 'package:amsl_app/models/hikari/quiz/question.dart' show BloomLevel;
import 'package:amsl_app/models/tori/quiz/question.dart';
import 'package:amsl_app/widgets/text/markdown_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class QuizQuestionAnswerField extends HookWidget {
  final Question question;

  final void Function(String) onChanged;
  const QuizQuestionAnswerField({
    super.key,
    required this.question,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    final selected = useState<Set<int>>(<int>{});

    useListenable(focusNode);

    useEffect(() {
      final answer = question.answer;
      if (answer != null && controller.text != answer) {
        controller.value = controller.value.copyWith(
          text: answer,
          selection: TextSelection.collapsed(offset: answer.length),
        );
      }
      return null;
    }, [question.answer, controller]);

    final textFieldFocused = focusNode.hasFocus && question.answer == null;

    void onOptionSelect(int index) {
      final updated = {...selected.value};
      if (updated.contains(index)) {
        updated.remove(index);
      } else {
        updated.add(index);
      }
      selected.value = updated;

      final options = question.options;
      if (options == null) {
        return;
      }
      final selectedString = updated.map((i) => options[i].option).join("\n");
      onChanged(selectedString);
    }

    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: focusNode.unfocus,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 12, color: theme.colorScheme.tertiary),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (!textFieldFocused) ...[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Thema: ",
                        style: theme.textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: question.topic,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                const Gap(8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Schwierigkeit: ",
                        style: theme.textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: _difficultyFromBloom(question.level),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                const Gap(16),
              ],
              MarkdownText(
                question.question,
                baseTextStyle: theme.textTheme.bodyMedium,
              ),
              const Gap(16),
              question.options == null
                  ? Expanded(
                      child: TextField(
                        readOnly: question.answer != null,
                        controller: controller,
                        onChanged: onChanged,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          hintText: "Schreibe deine Antwort... ",
                        ),
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        expands: true,
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(question.options!.length, (
                            i,
                          ) {
                            final option = question.options![i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: MultipleChoiceOption(
                                label: option.option,
                                isSelected: selected.value.contains(i),
                                onSelect: () => onOptionSelect(i),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

String _difficultyFromBloom(BloomLevel bloomLevel) {
  final level = bloomLevel.index + 1;
  final maxLevel = BloomLevel.values.length;
  return '${'★' * level}${'☆' * (maxLevel - level)}';
}
