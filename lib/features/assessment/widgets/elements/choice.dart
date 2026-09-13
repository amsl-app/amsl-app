import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Choice extends StatelessWidget {
  final dynamic value;
  final bool multiChoice;
  final List<dynamic> options;
  final Function(dynamic) onChange;
  final String label;
  final Color labelColor;

  const Choice({
    super.key,
    required this.multiChoice,
    required this.options,
    required this.value,
    required this.label,
    required this.onChange,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var value = (this.value ?? "");

    onTap(var choice) {
      value = choice;
      onChange(value);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium!.copyWith(color: labelColor),
        ),
        const Gap(25),
        Column(
          children: options
              .map(
                (choice) => ChoiceButton(
                  choice: choice,
                  onTap: onTap,
                  selected: value == choice,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final dynamic choice;
  final Function onTap;
  final bool selected;

  const ChoiceButton({
    super.key,
    required this.choice,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => onTap(choice),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.onSurface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CheckboxTheme(
                  data: CheckboxThemeData(
                    side: const BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: Checkbox(
                    value: selected,
                    onChanged: (value) => onTap(choice),
                    checkColor: theme.colorScheme.onSurface,
                    activeColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    choice.toString(),
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
